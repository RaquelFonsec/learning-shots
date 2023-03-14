
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "query", "results" ];
  static values = { trail: Number}

  connect() {
    if (!this.element.classList.contains("my-search-form")) {
      console.error("Incorrect element for search controller");
      return;
    }
    console.log("ola")

  }

  search(event) {
    event.preventDefault();

    if (this.hasQueryTarget && this.hasResultsTarget) {
      const query = this.queryTarget.value;
      fetch("/search", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({query: query})
      })
      .then(response => response.json())
      .then(data => {
        //console.log(data)
        if (data && data.video_url && data.video_url.length > 0) {
          const videos = data.video_url;
          let html = "";
          videos.forEach(video => {
            html += `
              <div class="video" data-controller="video-content"
                
              data-video-content-id-value="${video.id.videoId}">
                <div class="thumbnail">
                  <img src="${video.snippet.thumbnails.medium.url}">
                </div>
                <div class="info">
                  <h2>${video.snippet.title}</h2>
                  <p>${video.snippet.description}</p>
                </div>
                <a class="btn btn-sm btn-secondary" target="_blank" href="https://www.youtube.com/watch?v=${video.id.videoId}" >See video</a>
              </div>
            `;
          });


          if (this.hasResultsTarget) {
            this.resultsTarget.insertAdjacentHTML('beforeend', html);
          }
          else {
            console.error("No results target found");
          }
        }
        else {
          console.error("sem resultados");
        }
      })
      .catch(error => {
        console.error("fetch error:", error);

        if (this.hasResultsTarget) {
          this.resultsTarget.innerHTML = '<p class="error">Oops, something went wrong. Please try again later.</p>';
        }
        else {
          console.error("No results target found");
        }
      });
    }
    else {
      console.error("Missing query or results target");
    }
  }
}
