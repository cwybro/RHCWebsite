class ManageController < ApplicationController
  def index
    if current_user.try(:admin?)
      @user_events = Event.all
    else
      @user_events = Event.where('user_id == ?', (current_user.id))
    end
  end
end
