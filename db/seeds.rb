require 'net/http'
require 'json'
require 'faker'

VideoContent.destroy_all
Trail.destroy_all
User.destroy_all


#create_user_with_trails_and_videos("Pedro@gmail.com", "password 123456")
#create_user_with_trails_and_videos("Carlos@gmail.com", "password 123456")
user = User.create!(email: 'admin2@email.com', password: '123456')

# Define a função para obter os vídeos populares
def get_popular_videos
  url = "https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&regionCode=US&key=#{ENV["API_KEY"]}"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  result = JSON.parse(response)
  result["items"]

end


  # Criar trilhas para o usuário
  1.times do
    trails = Trail.create!(title: Faker::Book.title, user: user, category: Trail::CATEGORIES.sample.capitalize)

    # Obter os vídeos populares e adicione-os à trilha
    get_popular_videos.each do |video_contents|
      video_params = {}
      video_params[:video_id] = video_contents["id"]
      video_params[:title] = video_contents["snippet"]["title"]
      video_params[:thumb_url] = video_contents["snippet"]["thumbnails"]["standard"]["url"]
      video = VideoContent.new(video_params)
      video.trail = trails
      video.save
    end
  end
