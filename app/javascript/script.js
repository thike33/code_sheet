const headerBtn = document.querySelector(".js-header-btn");
const headerMenu = document.querySelector(".js-header-menu");
headerBtn.addEventListener("click", () => {
  headerBtn.classList.toggle("is-open");
  headerMenu.classList.toggle("is-open");
});