document.addEventListener("DOMContentLoaded", function () {
  // Smooth scroll effect for anchor links only
  const navMenuButtons = document.querySelectorAll("nav a");
  navMenuButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      const href = this.getAttribute("href");
      
      // Check if it's an anchor link (contains #)
      if (href && href.includes('#')) {
        // Extract the hash part (everything after #)
        const hash = href.substring(href.indexOf('#'));
        const targetElement = document.querySelector(hash);

        // If target element exists on current page, smooth scroll
        if (targetElement) {
          e.preventDefault();
          window.scrollTo({
            top: targetElement.offsetTop - 20,
            behavior: "smooth",
          });
        }
        // If target doesn't exist, let browser navigate normally (for cross-page links)
      }
    });
  });

  // Initialize the fun fact button
  const funFactButton = document.getElementById("fun-fact-btn");
  const funFact = document.getElementById("fun-fact");

  if (funFactButton && funFact) {
    funFactButton.addEventListener("click", function () {
      if (funFact.classList.contains("hidden")) {
        funFact.classList.remove("hidden");
        funFactButton.textContent = "Hide Fun Fact";
      } else {
        funFact.classList.add("hidden");
        funFactButton.textContent = "Click for a Fun Fact!";
      }
    });
  }
});
