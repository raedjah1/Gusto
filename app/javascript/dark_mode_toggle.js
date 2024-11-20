document.addEventListener("DOMContentLoaded", function() {
    const logo = document.querySelector(".logo-wrapper img");
    
    if (logo) { // Check if logo element exists
        logo.addEventListener("click", function() {
            document.body.classList.toggle("dark-theme");
            
            // Store the preference
            const isDarkMode = document.body.classList.contains("dark-theme");
            localStorage.setItem("darkMode", isDarkMode);
        });

        // Restore previous preference on page load
        const savedDarkMode = localStorage.getItem("darkMode");
        if (savedDarkMode === "true") {
            document.body.classList.add("dark-theme");
        }
    } else {
        console.warn("Logo element not found for dark mode toggle");
    }
});
  