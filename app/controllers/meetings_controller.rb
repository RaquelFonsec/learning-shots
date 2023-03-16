class MeetingsController < ApplicationController
before_action  :authenticate_user!


  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
    @meeting.trail =Trail.find(params[:trail_id])
   if @meeting.save
redirect_to meetings_path,notice: "trail added to calendar"

    end
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

def meeting_params
  params.require(:meeting).permit(:start_time,:end_time)

end
end
