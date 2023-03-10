class SearchController < ApplicationController

  BASE_URL = 'https://www.googleapis.com/youtube/v3/search'

  def index
    @query = params[:query]
    @results = YoutubeService.new(@query).call
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def perform_search(query)
    
    url = "#{BASE_URL}?part=snippet&q=#{URI.encode(query)}&key=#{ENV['YOUTUBE_API_KEY']}"
    response = HTTP.get(url)
    return [] unless response.code == 200

    JSON.parse(response.body)['items']
  end
end
