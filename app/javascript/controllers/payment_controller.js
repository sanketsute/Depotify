import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payment"
export default class extends Controller {
  static targets = ["selection", "additionalFields"]
  connect() {
  }
  initialize() {
    this.showAdditionalFields()
  }

  showAdditionalFields() {
    const selectedPaymentMethod = this.selectionTarget.value;
    if(Array.isArray(this.additionalFieldsTargets)) {
      this.additionalFieldsTargets.forEach(element => {
        element.disabled = element.hidden = element.dataset.type !== selectedPaymentMethod;
      });
  }
  }
}
