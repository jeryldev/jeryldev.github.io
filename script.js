document.addEventListener("DOMContentLoaded", function () {
  // Smooth scroll for anchor links
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

  // Dark mode toggle
  const darkModeToggle = document.getElementById('darkModeToggle');
  const html = document.documentElement;

  // Check for saved preference or system preference
  const savedTheme = localStorage.getItem('theme');
  const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

  if (savedTheme) {
    html.setAttribute('data-theme', savedTheme);
  } else if (systemPrefersDark) {
    html.setAttribute('data-theme', 'dark');
  }

  // Toggle dark mode on button click
  if (darkModeToggle) {
    darkModeToggle.addEventListener('click', function () {
      const currentTheme = html.getAttribute('data-theme');
      const newTheme = currentTheme === 'dark' ? 'light' : 'dark';

      html.setAttribute('data-theme', newTheme);
      localStorage.setItem('theme', newTheme);
    });
  }

  // Listen for system preference changes
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', function (e) {
    if (!localStorage.getItem('theme')) {
      html.setAttribute('data-theme', e.matches ? 'dark' : 'light');
    }
  });

  // Mobile navigation toggle
  const navToggle = document.getElementById('navToggle');
  const navMenu = document.getElementById('primary-nav');

  function closeNavMenu() {
    if (!navMenu || !navToggle) return;
    navMenu.classList.remove('is-open');
    navToggle.setAttribute('aria-expanded', 'false');
  }

  if (navToggle && navMenu) {
    navToggle.addEventListener('click', function (e) {
      e.stopPropagation();
      const isOpen = navMenu.classList.toggle('is-open');
      navToggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
    });

    navMenu.querySelectorAll('nav a').forEach(function (link) {
      link.addEventListener('click', closeNavMenu);
    });

    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && navMenu.classList.contains('is-open')) {
        closeNavMenu();
        navToggle.focus();
      }
    });

    document.addEventListener('click', function (e) {
      if (!navMenu.classList.contains('is-open')) return;
      if (navMenu.contains(e.target) || navToggle.contains(e.target)) return;
      closeNavMenu();
    });
  }
});
