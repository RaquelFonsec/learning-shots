import {Controller} from "@hotwired/stimulus";
import toastr from "toastr";

export default class extends Controller {
  connect() {
    this.displayFlashMessages()
  }

  displayFlashMessages() {
    const notice = this.data.get('notice')
    const alert = this.data.get('alert')

    if (notice) {
      toastr.success(notice)
    }

    if (alert) {
      toastr.error(alert)
    }
  }
}
