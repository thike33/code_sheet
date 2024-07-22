// PC時のユーザーメニュー
document.addEventListener("turbo:load", () => {
  const body = document.body;
  const isLoggedIn = body.getAttribute('data-logged-in') === 'true';
  if(isLoggedIn) {
    const headerUserBtn = document.querySelector(".js-user-btn");
    const headerUserMenu = document.querySelector(".js-user-menu");
    headerUserBtn.addEventListener("click", () => {
      headerUserBtn.classList.toggle("is-open");
      headerUserMenu.classList.toggle("is-open");
    });
  }
});

// SP時のヘッダーメニュー
document.addEventListener("turbo:load", () => {
  const headerBtn = document.querySelector(".js-header-btn");
  const headerMenu = document.querySelector(".js-header-menu");
  headerBtn.addEventListener("click", () => {
    headerBtn.classList.toggle("is-open");
    headerMenu.classList.toggle("is-open");
  });
});
