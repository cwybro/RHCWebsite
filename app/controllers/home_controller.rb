class HomeController < ApplicationController
  def index
    @admin = current_user.try(:admin?)
  end
end
