class LocationsController < ApplicationController
  def index
    @locations = Location.all

    
  end

  def show
    begin
     @location = Location.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Invalid id, location not found"
      redirect_to locations_path and return
    end
  end
end
