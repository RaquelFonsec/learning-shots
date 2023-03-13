class ReviewsController < ApplicationController
  def new
    @trail = Trail.find(params[:trail_id])
    @review = Review.new
  end

  def create
    @trail = Trail.find(params[:trail_id])
    @review = Review.new(review_params)
    @review.trail = @trail
    @review.user = current_user
    if @review.save
      redirect_to trail_path(@trail)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
