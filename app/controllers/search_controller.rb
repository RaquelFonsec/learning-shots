class SearchController < ApplicationController
#  skip_after_action :verify_authorized

  def search
    search_query = params[:query]
    video_url = YoutubeService.new(search_query).call
    if video_url.present?
      render json: { video_url: video_url }
    else
      render json: { error: "No videos found" }, status: :not_found
    end
  end
end
