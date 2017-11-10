class LocationsController < ApplicationController
  include LocationsHelper
  def index
    view_prefs, do_redirect= update_settings(params, session)
    if do_redirect
      flash.keep
      redirect_to locations_path(view_prefs) and return
    end
    @locations = filter_locations(view_prefs)

    @distance = view_prefs["distance_filter"]
    @location = view_prefs["location_filter"].to_s.strip

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


private
  def filter_locations(view_prefs)
    distance = view_prefs["distance_filter"].to_i
    location = view_prefs["location_filter"].to_s.strip
    if(location != "" && distance > 0)
      location=geocode_filter_location(location)
      begin
        @locations=Location.within(distance, :origin => location)
      rescue Geokit::Geocoders::GeocodeError
        flash[:warning]= "Geocode Error. Try again."
        redirect_to(locations_path(view_prefs)) and return
      end
    else
      @locations=Location.all
    end
    @locations
  end

  def update_settings(parms, sess)
    preferences = sess[:preferences] || Hash.new
    should_redirect = false
    { "distance_filter" => "","location_filter" => ""}.each do |parm, default|
      parmval = parms[parm]
      if parmval.nil?  # not currently set; look at session
        parmval = preferences[parm] || default
        should_redirect = true
      elsif parmval != preferences[parm]  # is set, but is it different?
        should_redirect = true
      end
      preferences[parm] = parmval
    end
    sess[:preferences] = preferences
    return preferences, should_redirect
  end
