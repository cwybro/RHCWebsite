class EventsController < ApplicationController
  include EventsHelper
  # before_action :authenticate_user!, :except => [:show, :index]

  def index

    if(params[:tag] && Tag.exists?(params[:tag]))
      if current_user.try(:admin?)
        @upcoming_events = Event.tagged_with(params[:tag]).where('datetime > ?', DateTime.now.beginning_of_day).order(:datetime)
      else
        @upcoming_events = Event.tagged_with(params[:tag]).where('datetime > ?', DateTime.now.beginning_of_day).order(:datetime)
                                                          .where('is_reviewed = ?', true)
      end
      @current_tag= Tag.find_by_id(params[:tag])
    else
      if current_user.try(:admin?)
        @upcoming_events = Event.where('datetime > ?', DateTime.now.beginning_of_day).order(:datetime)
      else
        @upcoming_events = Event.where('datetime > ?', DateTime.now.beginning_of_day).order(:datetime)
                                .where('is_reviewed = ?', true)
      end
    end
    @all_tags= Tag.all.map {|t| [t.name, t.id]}
    @all_tags.sort!
    @now = DateTime.now
  end

  def new
    if current_user.nil?
      flash[:warning] = "Log in first to create a new event!"
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
      flash[:warning] = "Log in first to edit an event!"
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
    if !current_user.try(:admin?) && !params[:is_reviewed].nil?
      flash[:warning] = "You don't have sufficient permission to edit this!"
      redirect_to event_path(@event) and return
    end
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
      @og = get_opengraph_obj(@event)
      rescue ActiveRecord::RecordNotFound
          flash[:warning] = "Invalid id, event not found"
          redirect_to events_path and return
      end
      days = @event.days_until(DateTime.now)
      @now = days < 1 ? "Today" : "#{days} days"
      @valid_permission = !current_user.nil? && (current_user.admin || current_user.id == @event.user_id)
  end

  private
  def create_update_params
    params.require(:event).permit(:user_id, :is_reviewed, :title, :description, :address, :datetime, :image)
  end
end
