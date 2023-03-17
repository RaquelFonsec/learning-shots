class TrailsController < ApplicationController
 # before_action :set_trail, only: %i[ show edit update destroy ]
#  skip_after_action :verify_authorized

 def index
  if params[:filter].present?
    @trails = Trail.where(category: params[:filter].capitalize)
  else
    @trails = Trail.all
  end
 #   authorize @trails
  end

  def my_trails
    @trails = current_user.trails
  end

  def show
    @trail = Trail.find(params[:id])
    @average = @trail.reviews.empty? ? 0 : @trail.reviews.pluck(:rating).reduce(:+) / @trail.reviews.count
    @video_content = VideoContent.new
 #   authorize @trail
  end

  def new
    @trail = Trail.new
 #   authorize @trail

  end

  def create
    @trail = Trail.new(trail_params)
    @trail.user = current_user
  #  authorize @trail
    if @trail.save
      redirect_to my_trails_path, notice: "Trail created successfully"
    else
      render :new
    end
  end

  def edit
    @trail = Trail.find(params[:id])
 #   authorize @trail
  end

  def update
 #   authorize @trail
    @trail= Trail.find(params[:id])
    if @trail.update(trail_params)
      redirect_to trail_path(@trail), notice: "Trail updated successfully"
    else
      render :edit
    end
  end

  def destroy
  #  authorize @trail
    @trail = Trail.find(params[:id])
    @trail.destroy

    redirect_to trails_path, status: :see_other, notice: "Trail deleted successfully"
  end

  def search
    @results = YoutubeService.new.search_videos(params[:query])
  end

  private

  def trail_params
    params.require(:trail).permit(:title, :description, :category, :photo)
  end
end
