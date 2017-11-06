class EventsController < ApplicationController

  def index
    @upcoming_events = Event.where('datetime > ?', DateTime.now.beginning_of_day).order(:datetime)
  end

  def new
    @event= Event.new
  end

  def create
    p=Event.new(create_update_params)
    if p.save
      flash[:notice] = "New event \"#{p.title}\" created"
      redirect_to events_path
    else
      flash[:warning]= "Error creating new event"
      redirect_to new_event_path(p)
    end
  end

  def show
    begin
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Invalid id, event not found"
      redirect_to events_path and return
    end
  end

  private
  def create_update_params
    params.require(:event).permit(:title, :description, :address, :datetime)
  end
end
