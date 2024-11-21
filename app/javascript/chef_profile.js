document.addEventListener("DOMContentLoaded", () => {
  const formTitle = document.querySelector(".form-title");
  const sidebar = document.querySelector(".info-sidebar");
  const formWrapper = document.querySelector(".form-wrapper");
  const infoCard = document.querySelector(".info-card");
  const inputFields = document.querySelectorAll(".input-field");

  // Smooth scroll animation when form comes into view
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = "1";
        entry.target.style.transform = "translateY(0)";
      }
    });
  }, { threshold: 0.1 });

  [formWrapper, sidebar].forEach(element => {
    element.style.opacity = "0";
    element.style.transform = "translateY(20px)";
    observer.observe(element);
  });

  // Subtle hover animations for form elements
  inputFields.forEach(input => {
    input.addEventListener("focus", () => {
      input.style.transform = "translateY(-2px)";
      input.style.boxShadow = "0 4px 12px rgba(0,0,0,0.08)";
      input.style.borderColor = getComputedStyle(document.documentElement)
        .getPropertyValue('--primary-color').trim();
    });

    input.addEventListener("blur", () => {
      input.style.transform = "none";
      input.style.boxShadow = "none";
      input.style.borderColor = "";
    });
  });

  // Gentle sidebar animation on scroll
  let lastScrollY = window.scrollY;
  window.addEventListener("scroll", () => {
    const currentScrollY = window.scrollY;
    const scrollDirection = currentScrollY > lastScrollY ? "down" : "up";
    
    if (sidebar) {
      const translateY = scrollDirection === "down" ? "-5px" : "0";
      sidebar.style.transform = `translateY(${translateY})`;
      sidebar.style.transition = "transform 0.3s ease-out";
    }
    
    lastScrollY = currentScrollY;
  });

  // Form validation feedback
  const form = document.querySelector(".profile-form");
  if (form) {
    form.addEventListener("submit", (e) => {
      let isValid = true;
      
      inputFields.forEach(input => {
        if (!input.value.trim()) {
          isValid = false;
          input.classList.add("error");
          const errorMsg = document.createElement("div");
          errorMsg.className = "error-message";
          errorMsg.textContent = "This field is required";
          input.parentNode.appendChild(errorMsg);
        }
      });

      if (!isValid) {
        e.preventDefault();
        formWrapper.classList.add("shake");
        setTimeout(() => formWrapper.classList.remove("shake"), 500);
      }
    });

    // Clear error states on input
    inputFields.forEach(input => {
      input.addEventListener("input", () => {
        input.classList.remove("error");
        const errorMsg = input.parentNode.querySelector(".error-message");
        if (errorMsg) {
          errorMsg.remove();
        }
      });
    });
  }
});
