import { Controller } from "@hotwired/stimulus"

// Reorders list items with Move up / Move down buttons.
// The hidden turn_ids[] inputs move with their item, so the form submits the order on screen.
export default class extends Controller {
  static targets = ["list", "item"]

  moveUp(event) {
    const item = event.target.closest("[data-reorder-target='item']")
    const previous = item.previousElementSibling
    if (previous) previous.before(item)
    this.#refocus(event.target)
  }

  moveDown(event) {
    const item = event.target.closest("[data-reorder-target='item']")
    const next = item.nextElementSibling
    if (next) next.after(item)
    this.#refocus(event.target)
  }

  // Moving a node can drop focus; keep it on the button the learner pressed.
  #refocus(button) {
    button.focus()
  }
}
