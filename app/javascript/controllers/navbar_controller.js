import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static classes = [ "scrolled" ]

  connect() {
    this.toggleNavbarStyles()
  }

  toggleNavbarStyles() {
    if (window.scrollY > 10) {
      this.element.classList.add(this.scrolledClass)
    } else {
      this.element.classList.remove(this.scrolledClass)
    }
  }
}
