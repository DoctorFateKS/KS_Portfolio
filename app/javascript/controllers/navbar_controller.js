import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu", "button"]; // Added button target

  connect() {
    this.isOpen = false;
  }

  toggleMenu(event) {
    if (event) event.preventDefault();
    this.isOpen = !this.isOpen;

    this.menuTarget.classList.toggle("is-open", this.isOpen);
    this.buttonTarget.classList.toggle("is-open", this.isOpen);
    this.buttonTarget.setAttribute("aria-expanded", this.isOpen);
    document.body.classList.toggle("no-scroll", this.isOpen);
  }

  // Prevents the menu from staying locked if window is resized
  toggleNavbarStyles() {
    this.element.classList.toggle("navbar--scrolled", window.scrollY > 20);
  }
}
