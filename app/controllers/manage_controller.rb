class ManageController < ApplicationController
  def index
    if current_user.try(:admin?)
      @user_events = Event.all
      @now = DateTime.now
    else
      @user_events = Event.where('user_id == ?', (current_user.id))
      @now = DateTime.now
    end
  end
end
