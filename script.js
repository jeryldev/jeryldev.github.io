document.addEventListener("DOMContentLoaded", function () {
  const navMenuButtons = document.querySelectorAll("nav a");
  navMenuButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      const href = this.getAttribute("href");

      if (href && href.includes('#')) {
        const hash = href.substring(href.indexOf('#'));
        const targetElement = document.querySelector(hash);

        if (targetElement) {
          e.preventDefault();
          const isHomepage = document.body.classList.contains('homepage');
          const headerOffset = isHomepage ? document.querySelector('header').offsetHeight + 40 : 20;
          window.scrollTo({
            top: targetElement.offsetTop - headerOffset,
            behavior: "smooth",
          });
        }
      }
    });
  });
});
