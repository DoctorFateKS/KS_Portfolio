import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "cta", "anchor"]
  static classes = ["scrolled"]

  connect() {
    // 1. Initialisation de l'Observer pour la performance du scroll
    this.initObserver()

    // 2. Gestion des événements clavier
    this.handleKeyboardEvent = this.handleKeyboardEvent.bind(this)
    document.addEventListener("keydown", this.handleKeyboardEvent)

    // 3. Nettoyage du cache Turbo (évite les bugs visuels au retour arrière)
    this.prepareForTurboCache = this.prepareForTurboCache.bind(this)
    document.addEventListener("turbo:before-cache", this.prepareForTurboCache)
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
    document.removeEventListener("keydown", this.handleKeyboardEvent)
    document.removeEventListener("turbo:before-cache", this.prepareForTurboCache)
    this.cleanupState()
  }

  // --- LOGIQUE DE PERFORMANCE (SCROLL) ---

  initObserver() {
    // L'IntersectionObserver ne s'active que lorsque l'élément "anchor"
    // entre ou sort de la vue. Pas de calculs inutiles pendant le scroll.
    this.observer = new IntersectionObserver(([entry]) => {
      // Si on ne voit plus l'ancre, on ajoute la classe "scrolled"
      this.element.classList.toggle(this.scrolledClasses[0], !entry.isIntersecting)
    }, { threshold: [1.0] })

    if (this.hasAnchorTarget) {
      this.observer.observe(this.anchorTarget)
    }
  }

  // --- GESTION DU MENU ---

  toggleMenu() {
    const isOpen = this.menuTarget.classList.toggle("is-open")
    document.body.classList.toggle("no-scroll", isOpen)

    const toggleButton = this.element.querySelector(".navbar__toggle")
    if (toggleButton) {
      toggleButton.setAttribute("aria-expanded", isOpen)
    }

    if (isOpen) {
      const firstLink = this.menuTarget.querySelector(".navbar__link")
      if (firstLink) {
        // On attend la prochaine frame de rendu pour le focus (évite le Layout Thrashing)
        requestAnimationFrame(() => firstLink.focus())
      }
    }
  }

  closeMenu() {
    if (this.menuTarget.classList.contains("is-open")) {
      this.cleanupState()

      const toggleButton = this.element.querySelector(".navbar__toggle")
      if (toggleButton) toggleButton.focus()
    }
  }

  // --- UTILS ---

  cleanupState() {
    this.menuTarget.classList.remove("is-open")
    document.body.classList.remove("no-scroll")
  }

  handleKeyboardEvent(event) {
    if (event.key === "Escape") this.closeMenu()
  }

  prepareForTurboCache() {
    // On ferme le menu avant que Turbo ne prenne une photo de la page
    this.cleanupState()
  }

  // Handle CTA button loading state
  setCtaLoading(isLoading = true) {
    if (this.hasCtaTarget) {
      this.ctaTarget.classList.toggle("is-loading", isLoading)
      this.ctaTarget.disabled = isLoading
    }
  }
}
