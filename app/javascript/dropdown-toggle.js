document.addEventListener("DOMContentLoaded", function () {
    const dropdownButton = document.querySelector(".dropdown-toggle");
    const dropdownMenu = document.querySelector(".dropdown-menu");
  
    dropdownButton.addEventListener("click", function () {
      dropdownMenu.classList.toggle("show");
    });
  });
  