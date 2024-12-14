import "@hotwired/turbo-rails";
import "./dark_mode_toggle";  
import "controllers";
import './dropdown-toggle';
import "@nathanvda/cocoon";

document.addEventListener("turbo:load", function () {
  // Check and apply saved dark mode preference
  const savedDarkMode = localStorage.getItem("darkMode");
  
  if (savedDarkMode === "true") {
    document.body.classList.add("dark-theme");
  } else {
    document.body.classList.remove("dark-theme");
  }

  // Handle removal of ingredient fields
  document.addEventListener('click', function (e) {
    if (e.target.closest('.js-remove-ingredient')) {
      e.preventDefault();
      const ingredientFields = e.target.closest('.ingredient-fields');
      const destroyField = ingredientFields.querySelector('input[name*="_destroy"]');
      
      if (destroyField) {
        destroyField.value = '1'; // Mark the ingredient for destruction
        ingredientFields.style.display = 'none'; // Hide the ingredient fields
      }
    }
  });
});
