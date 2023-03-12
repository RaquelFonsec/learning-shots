
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "query", "results" ];

  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  search() {
    const query = this.queryTarget.value;
    fetch(`https://www.googleapis.com/youtube/v3/search?part=snippet&q=${query}&type=video&key=AIzaSyCYexxBwGIUGtiNzrZ7r4i1EzGgGM3Cv1g`)
    .then(response => response.json())
    .then(data => {
      console.log(data);
      if (data.items.length > 0) {
        const videos = data.items;
        let html = "";
        videos.forEach(video => {
          html += `<div class="video" data-id="${video.id.videoId}">
            <div class="thumbnail">
              <img src="${video.snippet.thumbnails.medium.url}">
            </div>
            <div class="info">
              <h2>${video.snippet.title}</h2>
              <p>${video.snippet.description}</p>
            </div>
          </div>`;
        });

        if (this.hasResultsTarget) {
          this.resultsTarget.innerHTML = html;
        } else {
          console.error("No results target found");
        }
      } else {
        console.error("No videos found");
      }
    })
    .catch(error => {
      console.error("fetch error:", error);
      this.resultsTarget.innerHTML = "";
    });
  }
}
