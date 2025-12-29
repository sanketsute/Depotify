import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static outlets = [ "slideover" ]

  connect() {
  }

  open(event) {
    event.preventDefault()
   
    if (this.hasSlideoverOutlet) {
      this.slideoverOutlet.open()
    } else {
      console.error("Could not find the slideover controller. Check the ID #cart-modal")
    }
  }
}