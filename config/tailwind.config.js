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
          50: '#edeaf1',
          200: '#c8bdd4',
          100: '#ae9dbf',
          300: '#8870a1',
          400: '#71558f',
          500: '#565264',
          600: '#432463',
          700: '#371e52',
          800: '#2b173f',
          900: '#211230',
          background: '#565264'
        },
        secondary: {
          50: '#FAE7E8',
          100: '#EFB4B9',
          200: '#E78F97',
          300: '#DC5C67',
          400: '#D53D49',
          500: '#A6808C',
          600: '#B90B19',
          700: '#900914',
          800: '#70070F',
          900: '#55050C'
        },
        accent: '#0A4E6B',
        gray: '#C6C6C8',
        'gray-8': '#F3F2F8',
        'gray-7': '#D7D7D8',
        'gray-6': '#C6C6C8',
        'gray-5': '#A2A2A2',
        'gray-4': '#3A3A3C',
        'gray-3': '#262626',
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
          600: '#829ECE'
        },
        'purple-dark': '#432463',
        'purple-light': '#4E2A73',
        red: '#CB0C1C',
        'blue-marine': '#003A5D',
        'blue-light': '#EFF6FF',
        'blue-teal': '#00AFAA',
        'blue-teal-light': '#CDD9EC',
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
