/*
# Create entries table for Cancák partner diary

1. New Tables
- `entries` — stores shared diary entries (zápisky) between two partners.
  - `id` (uuid, primary key)
  - `title` (text, not null) — název zážitku
  - `content` (text, not null) — textový zápisek
  - `event_date` (date, not null) — datum události
  - `media_urls` (text[]) — array of cloud storage URLs for photos/videos
  - `media_types` (text[]) — array of media types ('image' or 'video') parallel to media_urls
  - `latitude` (double precision, nullable) — GPS latitude
  - `longitude` (double precision, nullable) — GPS longitude
  - `location_name` (text, nullable) — ručně zadaný název místa
  - `author` (text, not null, default 'partner') — who wrote the entry
  - `created_at` (timestamptz, default now())

2. Security
- Enable RLS on `entries`.
- This is a single-tenant shared diary (no auth/login screen — access is gated by a passphrase in the frontend).
- Allow anon + authenticated full CRUD since data is intentionally shared between the two partners.
- Storage bucket `media` is created as public for shared photo/video access.

3. Storage
- Create public bucket `media` for uploading photos and videos.
- Set public storage policies so both partners can upload and view media.
*/

CREATE TABLE IF NOT EXISTS entries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  content text NOT NULL,
  event_date date NOT NULL,
  media_urls text[] NOT NULL DEFAULT '{}',
  media_types text[] NOT NULL DEFAULT '{}',
  latitude double precision,
  longitude double precision,
  location_name text,
  author text NOT NULL DEFAULT 'partner',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE entries ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_select_entries" ON entries;
CREATE POLICY "anon_select_entries" ON entries FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_entries" ON entries;
CREATE POLICY "anon_insert_entries" ON entries FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_entries" ON entries;
CREATE POLICY "anon_update_entries" ON entries FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_entries" ON entries;
CREATE POLICY "anon_delete_entries" ON entries FOR DELETE
  TO anon, authenticated USING (true);

-- Create index for chronological ordering
CREATE INDEX IF NOT EXISTS idx_entries_event_date ON entries(event_date DESC);
CREATE INDEX IF NOT EXISTS idx_entries_created_at ON entries(created_at DESC);

-- Create public storage bucket for media
INSERT INTO storage.buckets (id, name, public)
VALUES ('media', 'media', true)
ON CONFLICT (id) DO NOTHING;

-- Storage policies: allow anon + authenticated to upload, read, and delete media
DROP POLICY IF EXISTS "anon_upload_media" ON storage.objects;
CREATE POLICY "anon_upload_media" ON storage.objects
  FOR INSERT TO anon, authenticated WITH CHECK (bucket_id = 'media');

DROP POLICY IF EXISTS "anon_read_media" ON storage.objects;
CREATE POLICY "anon_read_media" ON storage.objects
  FOR SELECT TO anon, authenticated USING (bucket_id = 'media');

DROP POLICY IF EXISTS "anon_delete_media" ON storage.objects;
CREATE POLICY "anon_delete_media" ON storage.objects
  FOR DELETE TO anon, authenticated USING (bucket_id = 'media');
