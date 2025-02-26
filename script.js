document.addEventListener("DOMContentLoaded", function () {
  // Smooth scroll effect
  const navMenuButtons = document.querySelectorAll("nav a");
  navMenuButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      e.preventDefault();

      const targetId = this.getAttribute("href");
      const targetElement = document.querySelector(targetId);

      window.scrollTo({
        top: targetElement.offsetTop - 20,
        behavior: "smooth",
      });
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
