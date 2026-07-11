import { Controller } from "@hotwired/stimulus"

// app/javascript/controllers/math_controller.js
//
// Rend les équations LaTeX (KaTeX) dans le contenu d'un article.
// KaTeX est chargé une fois via CDN dans le layout — voir les balises
// <script> à ajouter dans le <head>.
//
// Syntaxe dans le Markdown de l'article :
//   \( E = mc^2 \)        → équation en ligne
//   \[ \int_0^1 x^2 dx \]  → équation en bloc, centrée
//
// (delimiters \( \) et \[ \] plutôt que $ $ : évite toute confusion
// avec un dollar écrit normalement dans un article, ex. "coûte $5")
export default class extends Controller {
  connect() {
    this.renderMath()
  }

  renderMath() {
    if (typeof renderMathInElement === "undefined") {
      // KaTeX pas encore chargé (rare, uniquement au tout premier
      // affichage de page) : on retente une fois au prochain tick.
      requestAnimationFrame(() => {
        if (typeof renderMathInElement !== "undefined") this.renderMath()
      })
      return
    }

    renderMathInElement(this.element, {
      delimiters: [
        { left: "\\[", right: "\\]", display: true },
        { left: "\\(", right: "\\)", display: false },
      ],
      throwOnError: false,
    })
  }
}
