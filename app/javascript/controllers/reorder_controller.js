import { Controller } from "@hotwired/stimulus"

// Reorders list items with Move up / Move down buttons.
// The hidden turn_ids[] inputs move with their item, so the form submits the order on screen.
export default class extends Controller {
  static targets = ["list", "item", "number", "status"]

  moveUp(event) {
    const item = this.#itemFor(event)
    const previous = item.previousElementSibling
    if (previous) previous.before(item)
    this.#afterMove(item, event.currentTarget, previous ? null : "Already first.")
  }

  moveDown(event) {
    const item = this.#itemFor(event)
    const next = item.nextElementSibling
    if (next) next.after(item)
    this.#afterMove(item, event.currentTarget, next ? null : "Already last.")
  }

  #itemFor(event) {
    return event.currentTarget.closest("[data-reorder-target='item']")
  }

  #afterMove(item, button, boundaryMessage) {
    this.#renumber()
    // Moving a node can drop focus; keep it on the button the learner pressed.
    button.focus()

    const position = this.itemTargets.indexOf(item) + 1
    this.statusTarget.textContent =
      boundaryMessage || `Moved to position ${position} of ${this.itemTargets.length}.`
  }

  #renumber() {
    this.numberTargets.forEach((number, index) => { number.textContent = `${index + 1}.` })
  }
}
