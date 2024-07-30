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
        'simple': '0px 0px 25px 0px rgba(0, 0, 0, 0.50)'
      },
      fontFamily: {
        sans: ['Roboto', ...defaultTheme.fontFamily.sans]
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
        'gray-3': '#262626',
        'purple-dark': '#432463',
        'purple-light': '#4E2A73',
        red: '#CB0C1C',
        blue: '#0A4E6B',
        'green-dark': '#62C554',
        'green-light': '#D8F1D4'
      },
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries')
  ]
}
