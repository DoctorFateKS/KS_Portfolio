import { Controller } from "@hotwired/stimulus"

// app/javascript/controllers/navbar_controller.js
export default class extends Controller {
  static targets = ["overlay", "button", "link", "indicator", "hamburger"]
  static values = { pages: Array }

  connect() {
    console.log("navbar controller connecté !")

    this.isOpen = false
    this.updateIndicator()

    // Ferme automatiquement le menu si l'utilisateur navigue via Turbo
    // (retour arrière navigateur, clic sur un lien externe au menu, etc.)
    this.boundCloseOnVisit = () => this.close()
    document.addEventListener("turbo:before-visit", this.boundCloseOnVisit)

    // Navigation clavier type "diapositives" : flèches gauche/droite
    // pour circuler entre les pages, uniquement quand le menu est fermé
    this.boundArrowNav = this.handleArrowNav.bind(this)
    document.addEventListener("keydown", this.boundArrowNav)
  }

  disconnect() {
    document.removeEventListener("turbo:before-visit", this.boundCloseOnVisit)
    document.removeEventListener("keydown", this.boundArrowNav)
  }

  toggle() {
    this.isOpen ? this.close() : this.open()
  }

  open() {
    this.isOpen = true
    this.lastFocused = document.activeElement

    this.overlayTarget.classList.add("is-open")
    this.overlayTarget.removeAttribute("inert")
    this.buttonTarget.setAttribute("aria-expanded", "true")
    this.buttonTarget.setAttribute("aria-label", "Fermer le menu de navigation")

    // Premier lien focusé pour les utilisateurs clavier / lecteurs d'écran
    this.linkTargets[0]?.focus()

    document.addEventListener("keydown", this.handleKeydownBound = this.handleKeydown.bind(this))
  }

  close() {
    if (!this.isOpen) return
    this.isOpen = false

    this.overlayTarget.classList.remove("is-open")
    this.overlayTarget.setAttribute("inert", "")
    this.buttonTarget.setAttribute("aria-expanded", "false")
    this.buttonTarget.setAttribute("aria-label", "Ouvrir le menu de navigation")

    document.removeEventListener("keydown", this.handleKeydownBound)

    // Rend le focus à l'élément qui avait ouvert le menu
    this.lastFocused?.focus()
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      event.preventDefault()
      this.close()
      return
    }

    if (event.key === "Tab") {
      this.trapFocus(event)
    }
  }

  trapFocus(event) {
    const focusable = [this.buttonTarget, ...this.linkTargets].filter(
      (el) => el && !el.disabled
    )
    const first = focusable[0]
    const last = focusable[focusable.length - 1]

    if (event.shiftKey && document.activeElement === first) {
      event.preventDefault()
      last.focus()
    } else if (!event.shiftKey && document.activeElement === last) {
      event.preventDefault()
      first.focus()
    }
  }

  handleArrowNav(event) {
    if (this.isOpen) return
    if (!this.hasPagesValue || this.pagesValue.length === 0) return
    if (!["ArrowRight", "ArrowLeft"].includes(event.key)) return

    // Ignore si le focus est dans un champ de saisie
    const tag = document.activeElement?.tagName
    if (["INPUT", "TEXTAREA", "SELECT"].includes(tag)) return

    const currentPath = window.location.pathname
    const currentIndex = this.pagesValue.indexOf(currentPath)
    if (currentIndex === -1) return

    const delta = event.key === "ArrowRight" ? 1 : -1
    const nextIndex = (currentIndex + delta + this.pagesValue.length) % this.pagesValue.length
    const nextPath = this.pagesValue[nextIndex]

    if (window.Turbo) {
      window.Turbo.visit(nextPath)
    } else {
      window.location.href = nextPath
    }
  }

  updateIndicator() {
    if (!this.hasIndicatorTarget || !this.hasPagesValue) return
    const currentIndex = this.pagesValue.indexOf(window.location.pathname)
    if (currentIndex === -1) {
      this.indicatorTarget.textContent = ""
      return
    }
    const total = String(this.pagesValue.length).padStart(2, "0")
    const current = String(currentIndex + 1).padStart(2, "0")
    this.indicatorTarget.textContent = `${current} / ${total}`
  }
}
