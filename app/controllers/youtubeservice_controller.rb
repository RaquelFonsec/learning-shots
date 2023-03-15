

class YoutubeserviceController < ApplicationController

  BASE_URL = 'https://www.googleapis.com/youtube/v3/search'


    def initialize(query)
      @query = query
    end

    def call
      url = "#{BASE_URL}?#{URI.encode_www_form(params)}"
      response = HTTP.get(url)
      return [] unless response.code == 200

      results = JSON.parse(response.body)['items']
      results.map do |item|
        {
          id: item['id']['videoId'],
          title: item['snippet']['title'],
          description: item['snippet']['description'],
          thumbnail_url: item['snippet']['thumbnails']['default']['url']
        }
      end
    end

    private

    def params
      {
        part: 'snippet',
        q: @query,
        type: 'video',
        key: ENV['YOUTUBE_API_KEY']
      }
    end
  end
