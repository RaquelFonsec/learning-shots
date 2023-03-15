

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="video-content"
export default class extends Controller {
  static values = {id: String, title: String, description: String, thumbnail: String, trail: String}
  static targets = ["button", "message"]

  connect() {

  }
  create(event){
    event.preventDefault()
    let params = { "video_id": this.idValue, "title": this.titleValue, "description": this.descriptionValue, "thumb_url": this.thumbnailValue, "trail_id": this.trailValue}
    console.dir(params)
    fetch(`/trails/${params.trail_id}/video_contents`, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify(params)
    })
    .then(response =>response.json())
    .then((data)=>{
      console.log(data)
      console.log(this.buttonTarget)
      this.buttonTarget.innerText = "Video Added"
      this.buttonTarget.disabled = true
      this.messageTarget.hidden = false
    })
  }
}
