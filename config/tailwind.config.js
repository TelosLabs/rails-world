const defaultTheme = require('tailwindcss/defaultTheme')
module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/builders/**/*.rb'
  ],
  theme: {
    extend: {
      boxShadow: {
        simple: '0px 0px 25px 0px rgba(0, 0, 0, 0.50)'
      },
      fontFamily: {
        sans: ['Roboto', ...defaultTheme.fontFamily.sans],
        karla: ['Karla', ...defaultTheme.fontFamily.sans]
      },
      maxWidth: {
        'screen-sm': '425px'
      },
      colors: {
        primary: {
          500: '#4e2a73',
          600: '#432463'
        },
        secondary: {
          500: '#CB0C1C'
        },
        grey: {
          50: '#F3F2F8',
          200: '#D7D7D8',
          300: '#C6C6C8',
          400: '#A2A2A2',
          600: '#3A3A3C',
          700: '#262626',
          800: '#1C1C1E'
        },
        green: {
          500: '#62C554'
        },
        bluegray: {
          50: '#F4F7FB',
          200: '#CDD9EC',
          600: '#829ECE'
        },
        red: '#CB0C1C', // Same as secondary but used for error messages specifically
        'blue-marine': '#003A5D',
        'blue-teal': '#00AFAA',
        yellow: '#F4BF4F'
      },
      animation: {
        'slow-ping': 'ping 4s cubic-bezier(0, 0, 0.2, 1) infinite'
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries')
  ]
}
