class EventsController < ApplicationController
  # before_action :authenticate_user!, :except => [:show, :index]

  def index
    if(params[:tag] && Tag.exists?(params[:tag]))
      @upcoming_events = Event.tagged_with(params[:tag]).where('datetime > ?', DateTime.now.beginning_of_day).order(:datetime)
      @current_tag= Tag.find_by_id(params[:tag])
    else
      @upcoming_events = Event.where('datetime > ?', DateTime.now.beginning_of_day).order(:datetime)
    end
    @all_tags= Tag.all.map {|t| [t.name, t.id]}
    @all_tags.sort!
  end

  def new
    @event= Event.new
  end

  def create
    p=Event.new(create_update_params)
    if p.save
      flash[:success] = "New event \"#{p.title}\" created"
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
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Invalid id, event not found"
      redirect_to events_path and return
    end
  end

  private
  def create_update_params
    params.require(:event).permit(:title, :description, :address, :datetime, :image)
  end
end
