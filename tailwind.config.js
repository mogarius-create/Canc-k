/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        forest: {
          50: '#f0f7f0',
          100: '#dcebdd',
          200: '#bbd7be',
          300: '#8fbb96',
          400: '#5e9268',
          500: '#3f7248',
          600: '#2d5b37',
          700: '#234729',
          800: '#1d3a23',
          900: '#17301b',
        },
        earth: {
          50: '#faf6f0',
          100: '#f3e9d7',
          200: '#e7d2b0',
          300: '#d6b585',
          400: '#c7995f',
          500: '#b87f47',
          600: '#a06a3a',
          700: '#835530',
          800: '#6d462b',
          900: '#5a3b25',
        },
        cream: {
          50: '#fefdf8',
          100: '#fdf9ed',
          200: '#faf0d3',
          300: '#f5e3b0',
          400: '#efd08a',
          500: '#e8bd66',
        },
        bark: {
          50: '#f7f5f2',
          100: '#e8e2d8',
          200: '#cfc5b3',
          300: '#b0a088',
          400: '#8e7b62',
          500: '#74614c',
          600: '#5e4d3c',
          700: '#4c3e31',
          800: '#3d3228',
          900: '#2f271f',
        },
      },
      fontFamily: {
        serif: ['Georgia', 'Cambria', 'Times New Roman', 'serif'],
        sans: ['system-ui', '-apple-system', 'sans-serif'],
      },
      backgroundImage: {
        'paper-texture': "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200' viewBox='0 0 200 200'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.04' numOctaves='5' stitchTiles='stitch'/%3E%3CfeColorMatrix type='saturate' values='0.15'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.08'/%3E%3C/svg%3E\")",
      },
      animation: {
        'fade-in': 'fadeIn 0.3s ease-out',
        'slide-up': 'slideUp 0.4s ease-out',
        'scale-in': 'scaleIn 0.2s ease-out',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { opacity: '0', transform: 'translateY(12px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        scaleIn: {
          '0%': { opacity: '0', transform: 'scale(0.95)' },
          '100%': { opacity: '1', transform: 'scale(1)' },
        },
      },
    },
  },
  plugins: [],
};
