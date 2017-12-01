class HomeController < ApplicationController
  def index
    @admin = current_user.try(:admin?)

    # @location_img = Location.first.image.url(:grid) unless !Location.first.image.present?
    # @event_img = Event.first.image.url(:thumb) unless !Event.first.image.present?
  end
end
