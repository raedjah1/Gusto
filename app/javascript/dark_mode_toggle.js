document.addEventListener("DOMContentLoaded", function() {
    const logo = document.querySelector(".logo-wrapper img");
    
    logo.addEventListener("click", function() {
      document.body.classList.toggle("dark-theme");
    });
  });
  