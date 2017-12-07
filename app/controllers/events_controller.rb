class EventsController < ApplicationController
  # before_action :authenticate_user!, :except => [:show, :index]

  def index
    @upcoming_events = Event.where('datetime > ?', DateTime.now.beginning_of_day).order(:datetime)
    @now = DateTime.now
  end

  def new
    if current_user.nil?
      flash[:warning] = "You must be logged in order to create a new event!"
      redirect_to new_user_session_path and return
    end
    @event = Event.new
  end

  def create
    p = Event.new(create_update_params)
    if p.save
      flash[:success] = "New event \"#{p.title}\" created"
      redirect_to events_path
    else
      flash[:warning]= "Error creating new event"
      redirect_to new_event_path(p)
    end
  end

  def edit
    if current_user.nil?
      flash[:warning] = "You must be logged in order to edit an event!"
      redirect_to new_user_session_path and return
    end
    id = params[:id]
    @event = Event.find(id)
    if !current_user.admin && current_user.id != @event.user_id
      flash[:warning] = "You don't have sufficient permission to edit this!"
      redirect_to event_path(@event) and return
    end
  end

  def update
    id = params[:id]
    e = Event.find(id)
    e.update(create_update_params)
    if e.save
      flash[:success] = "Event \"#{e.title}\" updated"
      redirect_to event_path(e.id)
    else
      flash[:error] = "Error updating event"
      redirect_to edit_event_path(e.id)
    end
  end

  def show
    begin
      @event = Event.find(params[:id])
      @now = "#{@event.days_until(DateTime.now)} days"
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Invalid id, event not found"
      redirect_to events_path and return
    end
  end

  private
  def create_update_params
    params.require(:event).permit(:user_id, :title, :description, :address, :datetime, :image)
  end
end
