document.addEventListener("turbo:load", () => {
  const body = document.body;
  const isLoggedIn = body.getAttribute('data-logged-in') === 'true';

  // メニュー開閉
  const toggleMenu = (btnSelector, menuSelector) => {
    const btn = document.querySelector(btnSelector);
    const menu = document.querySelector(menuSelector);
    if (btn && menu) {
      btn.addEventListener("click", () => {
        btn.classList.toggle("is-open");
        menu.classList.toggle("is-open");
      });
    }
  };

  // PC時のユーザーメニュー開閉
  if (isLoggedIn) {
    toggleMenu(".js-user-btn", ".js-user-menu");
  }

  // SP時のヘッダーメニュー開閉
  toggleMenu(".js-header-btn", ".js-header-menu");
});
