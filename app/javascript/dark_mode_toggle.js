// dark_mode_toggle.js
const initDarkMode = () => {
  const toggleDarkTheme = () => {
    document.body.classList.toggle("dark-theme");
    const isDarkMode = document.body.classList.contains("dark-theme");
    localStorage.setItem("darkMode", isDarkMode ? "true" : "false");

    // Toggle icon visibility (sun and moon)
    const sunIcon = document.getElementById("sun-icon");
    const moonIcon = document.getElementById("moon-icon");

    sunIcon.style.display = isDarkMode ? "none" : "inline-block";
    moonIcon.style.display = isDarkMode ? "inline-block" : "none";
  };

  // Check and apply saved dark mode preference
  const savedDarkMode = localStorage.getItem("darkMode");
  if (savedDarkMode === "true" || savedDarkMode === null) {
    document.body.classList.add("dark-theme");
    if (savedDarkMode === null) {
      localStorage.setItem("darkMode", "true");
    }
  }

  // Add click handler to toggle dark mode on the theme toggle button
  const themeToggleButton = document.getElementById("theme-toggle-button");
  if (themeToggleButton) {
    themeToggleButton.addEventListener("click", toggleDarkTheme);
  }

  // Initial display of icons based on current dark mode state
  const sunIcon = document.getElementById("sun-icon");
  const moonIcon = document.getElementById("moon-icon");
  if (sunIcon && moonIcon) {
    sunIcon.style.display = document.body.classList.contains("dark-theme") ? "none" : "inline-block";
    moonIcon.style.display = document.body.classList.contains("dark-theme") ? "inline-block" : "none";
  }
};

// Initialize on both initial load and subsequent Turbo navigations
document.addEventListener("turbo:load", initDarkMode);
document.addEventListener("turbo:render", initDarkMode);
