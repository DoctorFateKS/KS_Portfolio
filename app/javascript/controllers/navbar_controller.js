import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu", "cta" ]
  static classes = [ "scrolled" ]

  // Debounce timer for scroll events
  scrollTimeout = null

  connect() {
    // Add keyboard event listener for Escape key
    this.handleKeyboardEvent = this.handleKeyboardEvent.bind(this)
    document.addEventListener("keydown", this.handleKeyboardEvent)
  }

  disconnect() {
    // Clean up event listener
    document.removeEventListener("keydown", this.handleKeyboardEvent)
    if (this.scrollTimeout) {
      clearTimeout(this.scrollTimeout)
    }
  }

  toggleMenu() {
    const isOpen = this.menuTarget.classList.toggle("is-open")
    document.body.classList.toggle("no-scroll")

    // Update aria-expanded for accessibility
    const toggleButton = this.element.querySelector(".navbar__toggle")
    if (toggleButton) {
      toggleButton.setAttribute("aria-expanded", isOpen)
    }

    // Focus management: focus first link in menu when opened
    if (isOpen) {
      const firstLink = this.menuTarget.querySelector(".navbar__link")
      if (firstLink) setTimeout(() => firstLink.focus(), 100)
    }
  }

  // Handle Escape key to close mobile menu
  handleKeyboardEvent(event) {
    if (event.key === "Escape" && this.menuTarget.classList.contains("is-open")) {
      this.closeMenu()
    }
  }

  closeMenu() {
    this.menuTarget.classList.remove("is-open")
    document.body.classList.remove("no-scroll")

    // Return focus to toggle button
    const toggleButton = this.element.querySelector(".navbar__toggle")
    if (toggleButton) toggleButton.focus()
  }

  // Debounced scroll handler to improve performance
  toggleNavbarStyles() {
    if (this.scrollTimeout) {
      clearTimeout(this.scrollTimeout)
    }

    this.scrollTimeout = setTimeout(() => {
      if (window.scrollY > 10) {
        this.element.classList.add(this.scrolledClass)
      } else {
        this.element.classList.remove(this.scrolledClass)
      }
    }, 150)
  }

  // Handle CTA button loading state
  setCtaLoading(isLoading = true) {
    if (this.hasCtaTarget) {
      if (isLoading) {
        this.ctaTarget.classList.add("is-loading")
        this.ctaTarget.disabled = true
      } else {
        this.ctaTarget.classList.remove("is-loading")
        this.ctaTarget.disabled = false
      }
    }
  }
}
