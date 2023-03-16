class MeetingsController < ApplicationController
before_action  :authenticate_user!
before_action :set_trails,only: [:index,:new,:show]

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
   if @meeting.save
redirect_to meetings_path,notice: "trail added to calendar"
   else
    render :new, notice:@meeting.errors.messages
    end
  end

  def show
    @meeting = Meeting.find(params[:id])
  end

  def index
    # Scope your query to the dates being shown:
   # @start_date = params.fetch(:start_date, Date.today).to_date
    @start_date = (Date.today).to_date

    # For a monthly view:
   # @meetings = Meeting.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)

    # Or, for a weekly view:
      @meetings = Meeting.where(start_time: @start_date.beginning_of_week..@start_date.end_of_week)

  end
private

def set_trails
  @trails = Trail.where(user:current_user)
end

def meeting_params
  params.require(:meeting).permit(:trail_id,:start_time,:end_time)

end
end
