import "@hotwired/turbo-rails";
import "controllers";
import './dropdown-toggle';
import "./dark_mode_toggle";
import "@nathanvda/cocoon";

document.addEventListener("turbo:load", function () {
  // Set dark mode as default
  if (!localStorage.getItem("darkMode")) {
    document.body.classList.add("dark-theme");
    localStorage.setItem("darkMode", "true");
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
