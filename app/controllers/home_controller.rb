class HomeController < ApplicationController
  def index
    @admin = current_user.try(:admin?)
    @todays_events = Event.today
  end
end
