document.addEventListener("DOMContentLoaded", function () {
  // Function to toggle dark theme and save preference
  const toggleDarkTheme = () => {
    document.body.classList.toggle("dark-theme");
    const isDarkMode = document.body.classList.contains("dark-theme");
    localStorage.setItem("darkMode", isDarkMode ? "true" : "false");
  };

  // Check and apply saved dark mode preference on page load
  const savedDarkMode = localStorage.getItem("darkMode");
  if (savedDarkMode === "true") {
    document.body.classList.add("dark-theme");
  }

  // Add click handlers to logo images
  const logos = document.querySelectorAll(".logo-wrapper img, .chef-profile-container .form-wrapper img");

  logos.forEach((logo) => {
    logo.addEventListener("click", toggleDarkTheme);
  });
});
