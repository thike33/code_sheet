module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'main-color': '#A1D6E2', // light blue
        'sub-color': '#1995AD', // blue
        'bg-color': '#F1F1F2', // light grey
        'footer-color': '#BCBABE', // grey
      },
    },
  },
}
