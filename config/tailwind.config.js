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
        gray: '#C6C6C8',
        'gray-8': '#F3F2F8',
        'gray-7': '#D7D7D8',
        'gray-6': '#C6C6C8',
        'gray-5': '#A2A2A2',
        'gray-4': '#3A3A3C',
        'gray-3': '#262626',
        'purple-dark': '#432463',
        'purple-light': '#4E2A73',
        red: '#CB0C1C',
        blue: '#0A4E6B',
        'blue-2': '#829ECE',
        'green-dark': '#62C554',
        'green-light': '#D8F1D4',
        'blue-marine': '#003A5D',
        'blue-light': '#EFF6FF',
        'blue-teal': '#00AFAA'
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries')
  ]
}
