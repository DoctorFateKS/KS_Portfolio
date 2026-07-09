import { Controller } from "@hotwired/stimulus"

// app/javascript/controllers/carousel_controller.js
//
// Carousel horizontal simple, piloté par flèches + clavier, en plus
// du scroll natif (tactile/trackpad) qui fonctionne même sans JS.
//
// Usage :
//   <div data-controller="carousel">
//     <button data-carousel-target="prevButton" data-action="click->carousel#prev">‹</button>
//     <div data-carousel-target="track" tabindex="0"
//          data-action="keydown.left->carousel#prev keydown.right->carousel#next">
//       <article data-carousel-target="card">...</article>
//       ...
//     </div>
//     <button data-carousel-target="nextButton" data-action="click->carousel#next">›</button>
//   </div>
export default class extends Controller {
  static targets = ["track", "card", "prevButton", "nextButton"]

  connect() {
    this.updateButtonsState()
    this.boundUpdate = () => this.updateButtonsState()
    this.trackTarget.addEventListener("scroll", this.boundUpdate, { passive: true })
    // Recalcule aussi au redimensionnement (passage mobile/desktop)
    window.addEventListener("resize", this.boundUpdate)
  }

  disconnect() {
    this.trackTarget.removeEventListener("scroll", this.boundUpdate)
    window.removeEventListener("resize", this.boundUpdate)
  }

  next() {
    this.scrollByCard(1)
  }

  prev() {
    this.scrollByCard(-1)
  }

  scrollByCard(direction) {
    if (!this.hasCardTarget) return

    const card = this.cardTargets[0]
    const trackStyles = getComputedStyle(this.trackTarget)
    const gap = parseFloat(trackStyles.columnGap || trackStyles.gap || "0")
    const distance = (card.offsetWidth + gap) * direction

    const prefersReducedMotion = window.matchMedia(
      "(prefers-reduced-motion: reduce)"
    ).matches

    this.trackTarget.scrollBy({
      left: distance,
      behavior: prefersReducedMotion ? "auto" : "smooth",
    })
  }

  updateButtonsState() {
    const { scrollLeft, scrollWidth, clientWidth } = this.trackTarget
    const maxScroll = scrollWidth - clientWidth

    if (this.hasPrevButtonTarget) {
      this.prevButtonTarget.disabled = scrollLeft <= 4
    }
    if (this.hasNextButtonTarget) {
      this.nextButtonTarget.disabled = scrollLeft >= maxScroll - 4
    }
  }
}
