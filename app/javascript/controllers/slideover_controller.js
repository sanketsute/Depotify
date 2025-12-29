import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
static targets = ["backdrop", "panel", "container"]


  connect() {
    this.containerTarget.classList.add("hidden")
  }

  open() {
    let pathname = window.location.pathname 
    if(pathname.includes("/carts/")) {
      return;
    }
    this.containerTarget.classList.remove("hidden")
    setTimeout(() => {
        this.backdropTarget.classList.add("opacity-100")
        this.backdropTarget.classList.remove("opacity-0")
        this.panelTarget.classList.add("translate-x-0")
        this.panelTarget.classList.remove("translate-x-full")
    }, 10)
  }

  close() {
    this.backdropTarget.classList.remove("opacity-100")
    this.backdropTarget.classList.add("opacity-0")
    this.panelTarget.classList.remove("translate-x-0")
    this.panelTarget.classList.add("translate-x-full")

    setTimeout(() => {
       this.containerTarget.classList.add("hidden")
    }, 500) 
  }
}