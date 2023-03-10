import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = [ "query", "results" ];
  connect() {
    console.log("Hello, Stimulus!", this.element)

  }
  search(event) {
    event.preventDefault();
    console.log("caiu aqui")
    const query = this.queryTarget.value;
    fetch("/search",{
      method: "POST",
      headers: {"Accept": "application/json", "X-CSRF-Token": this.#getMetaValue("csrf-token") },
      body: {query: query}
    })
    .then(response => response.json())
    .then(data => {
    console.log(data)
    });
  }

  #getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }
}
