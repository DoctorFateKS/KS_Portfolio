import { Controller } from "@hotwired/stimulus"

// app/javascript/controllers/reveal_controller.js
//
// Révèle progressivement des éléments quand ils entrent dans le
// champ visible — que ce soit au scroll vertical (.page-content) ou
// horizontal (le track d'un carousel). Le sélecteur du conteneur de
// référence est configurable via data-reveal-root-selector-value,
// et vaut ".page-content" par défaut (comportement historique
// inchangé pour la page Profil).
//
// Usage vertical (inchangé) :
//   <div data-controller="reveal">
//     <div data-reveal-target="item">...</div>
//   </div>
//
// Usage horizontal (carousel) :
//   <div data-controller="reveal"
//        data-reveal-root-selector-value=".skills-carousel__track">
//     <article data-reveal-target="item">...</article>
//   </div>
export default class extends Controller {
  static targets = ["item"]
  static values = { rootSelector: { type: String, default: ".page-content" } }

  connect() {
    const prefersReducedMotion = window.matchMedia(
      "(prefers-reduced-motion: reduce)"
    ).matches

    if (prefersReducedMotion || !("IntersectionObserver" in window)) {
      this.itemTargets.forEach((el) => el.classList.add("is-visible"))
      return
    }

    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-visible")
            this.observer.unobserve(entry.target)
          }
        })
      },
      {
        root: this.element.closest(this.rootSelectorValue),
        threshold: 0.2,
      }
    )

    this.itemTargets.forEach((el) => this.observer.observe(el))
  }

  disconnect() {
    this.observer?.disconnect()
  }
}
