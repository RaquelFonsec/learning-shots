import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submit"
export default class extends Controller {
  static targets = [ "stars" ]
  connect() {console.log(this.starsTarget)}
  envia() {

    console.log(this.element)
    this.element.submit();
  }
}
