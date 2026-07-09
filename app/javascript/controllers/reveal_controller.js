import { Controller } from "@hotwired/stimulus"

// app/javascript/controllers/reveal_controller.js
//
// Révèle progressivement des éléments quand ils entrent dans le
// viewport visible — indispensable dès qu'une page dépasse 100vh et
// scrolle à l'intérieur de .page-content, sinon les animations
// calées sur le chargement de page se jouent hors champ, avant que
// l'utilisateur n'ait scrollé jusque-là.
//
// Usage :
//   <div data-controller="reveal">
//     <div data-reveal-target="item">...</div>
//     <div data-reveal-target="item">...</div>
//   </div>
export default class extends Controller {
  static targets = ["item"]

  connect() {
    const prefersReducedMotion = window.matchMedia(
      "(prefers-reduced-motion: reduce)"
    ).matches

    if (prefersReducedMotion || !("IntersectionObserver" in window)) {
      // Pas d'animation superflue : on affiche tout directement.
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
        // Observe par rapport au conteneur qui scrolle réellement
        // (.page-content), pas par rapport au viewport global.
        root: this.element.closest(".page-content"),
        threshold: 0.2,
      }
    )

    this.itemTargets.forEach((el) => this.observer.observe(el))
  }

  disconnect() {
    this.observer?.disconnect()
  }
}
