// Function to initialize dark mode
const initDarkMode = () => {
  // Function to toggle dark theme and save preference
  const toggleDarkTheme = () => {
    document.body.classList.toggle("dark-theme");
    const isDarkMode = document.body.classList.contains("dark-theme");
    localStorage.setItem("darkMode", isDarkMode ? "true" : "false");
  };

  // Check and apply saved dark mode preference
  const savedDarkMode = localStorage.getItem("darkMode");
  if (savedDarkMode === null || savedDarkMode === "true") {
    document.body.classList.add("dark-theme");
  }

  // Set dark mode as default if no preference is saved
  if (savedDarkMode === null) {
    localStorage.setItem("darkMode", "true");
  }

  // Add click handlers to logo images
  const logos = document.querySelectorAll(".logo-wrapper img, .chef-profile-container .form-wrapper img");
  logos.forEach((logo) => {
    logo.addEventListener("click", toggleDarkTheme);
  });
};

// Initialize on both initial load and subsequent Turbo navigations
document.addEventListener("turbo:load", initDarkMode);
document.addEventListener("turbo:render", initDarkMode);
