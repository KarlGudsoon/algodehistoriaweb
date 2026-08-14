/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./**/*.html",
    "./**/*.js",
    "./**/*.php",
    "!./node_modules/**",
    "!./sql/**",
  ],
  theme: {
    extend: {
      colors: {
        primary: "#e92a41",
        secondary: "#c2283a",
        accent: "#ffff00",
        dark: "#181818",
        prehistoria: "#f86d31",
        antigua: "#30a5e8",
        medieval: "#f8b229",
        moderna: "#2ecc71",
        contemporanea: "#9b59b6",
      },
      fontFamily: {
        heading: ["'Bebas Neue'", "sans-serif"],
        body: ["'Montserrat'", "sans-serif"],
      },
    },
  },
  plugins: [],
};
