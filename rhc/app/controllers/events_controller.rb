class EventsController < ApplicationController

  def index
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

  def edit
    id = params[:id]
    @event = Event.find(id)
  end

  def update
    id = params[:id]
    e = Event.find(id)
    e.update(create_update_params)
    if e.save
      flash[:notice] = "Event\"#{e.title}\" updated"
      redirect_to event_path(e.id)
    else
      flash[:error] = "Error updating event"
      redirect_to edit_event_path(e.id)
    end
  end

  private
  def create_update_params
    params.require(:event).permit(:title, :description, :address, :datetime)
  end
end
