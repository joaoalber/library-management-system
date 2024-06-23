// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function toggleMenu(elementId) {
  let element = document.getElementById(elementId);
  let currentDisplay = element.style.display || window.getComputedStyle(element).display;

  if (currentDisplay === "none") {
    element.style.display = "block";
  } else {
    element.style.display = "none";
  }
}

window.toggleMenu = toggleMenu;
