class HomeController < ApplicationController
  def index
    @admin = current_user.try(:admin?)
    @todays_events = Event.today
    @featured_events = Event.future.featured_events
  end
end
