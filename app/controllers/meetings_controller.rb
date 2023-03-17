class MeetingsController < ApplicationController
before_action  :authenticate_user!
before_action :set_trails,only: [:index,:new,:show,:edit,:update]


def index
  @start_date = params.fetch(:start_date, Date.today).to_date
    @meetings = Meeting.where(start_time: @start_date.beginning_of_week..@start_date.end_of_week,user: current_user)
    if @meetings.empty?

      @meetings = Meeting.where(end_time: @start_date.beginning_of_week..@start_date.end_of_week,user: current_user)
    end

end

def weekly
  @start_date = params.fetch(:start_date, Date.today).to_date
    @meetings = Meeting.where(start_time: @start_date.beginning_of_week..@start_date.end_of_week,user: current_user)
    if @meetings.empty?

      @meetings = Meeting.where(end_time: @start_date.beginning_of_week..@start_date.end_of_week,user: current_user)
    end

end


def monthly
  @start_date = params.fetch(:start_date, Date.today).to_date
    @meetings = Meeting.where(start_time: @start_date.beginning_of_month..@start_date.end_of_month,user: current_user)
    if @meetings.empty?

      @meetings = Meeting.where(end_time: @start_date.beginning_of_month..@start_date.end_of_month,user: current_user)
    end

end



  def new
    @meeting = Meeting.new
  end




def create
  @meeting = Meeting.new(meeting_params)
  @meeting.user = current_user
  if @meeting.save
    redirect_to meetings_path, notice: "trail added to calendar"
  else
    flash.now[:alert] = 'Não foi possível adicionar a trilha ao calendário'
    render :new
  end
end


  def show
    @meeting = Meeting.find(params[:id])
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(meeting_params)
      redirect_to @meeting
    else
      render 'edit'
    end
  end


  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy
    redirect_to meetings_path, notice: 'Reunião excluída com sucesso!'
  end


  #def index
    # Scope your query to the dates being shown:
   # @start_date = params.fetch(:start_date, Date.today).to_date
    #@start_date = (Date.today).to_date

    # For a monthly view:
   # @meetings = Meeting.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)

    # Or, for a weekly view:
     # @meetings = Meeting.where(start_time: @start_date.beginning_of_week..@start_date.end_of_week)

  #end
private

def set_trails
  @trails = Trail.where(user:current_user)
end

def meeting_params
  params.require(:meeting).permit(:trail_id,:start_time,:end_time)
end
end
