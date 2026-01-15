import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu" ]
  static classes = [ "scrolled" ]

  toggleMenu() {
    this.menuTarget.classList.toggle("is-open")
    document.body.classList.toggle("no-scroll")
  }

  toggleNavbarStyles() {
    if (window.scrollY > 10) {
      this.element.classList.add(this.scrolledClass)
    } else {
      this.element.classList.remove(this.scrolledClass)
    }
  }
}