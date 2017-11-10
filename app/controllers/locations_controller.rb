class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def new
      @location = Location.new
  end

  def create
    p=Location.new(create_update_params)
    if p.save
      flash[:notice] = "New location \"#{p.title}\" created"
      redirect_to locations_path
    else
      flash[:warning]= "Error creating new location"
      redirect_to new_location_path(p)
    end
  end

  private
  def create_update_params
    params.require(:location).permit(:title, :description, :address)
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
