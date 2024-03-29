class LocationsController < ApplicationController
  include LocationsHelper
  # before_action :authenticate_user!, :except => [:show, :index]

  def index
    view_prefs, do_redirect= update_settings(params, session)
    if do_redirect
      flash.keep
      redirect_to locations_path(view_prefs) and return
    end
    @locations = filter_locations(view_prefs)

    @distance = view_prefs["distance_filter"]
    @location = view_prefs["location_filter"].to_s.strip
    @admin = current_user.try(:admin?)
  end

  def new
    if current_user.try(:admin?)
      @location = Location.new
    else
      flash[:warning] = "Invalid permissions"
      redirect_to locations_path and return
    end
  end

  def create
    if current_user.try(:admin?)
      p=Location.new(create_update_params)
      if p.save
        flash[:notice] = "New location \'#{p.title}\' created"
        redirect_to locations_path
      else
        flash[:warning]= "Error creating new location"
        redirect_to new_location_path(p)
      end
    else
      flash[:warning] = "Invalid permissions"
      redirect_to locations_path and return
    end
  end

  def show
    begin
      @location = Location.find(params[:id])
      @og = get_opengraph_obj(@location)
      @admin = current_user.try(:admin?)

      api_key = ENV['GOOGLE_API_KEY']
      coords = [@location.lat, @location.lng].join(',')
      @google_src = "https://www.google.com/maps/embed/v1/place?key=#{api_key}&q=#{coords}"
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Invalid id, location not found"
      redirect_to locations_path and return
    end
  end

  def edit
    if current_user.try(:admin?)
      id = params[:id]
      @location = Location.find(id)
    else
      flash[:warning] = "Invalid permissions"
      redirect_to locations_path and return
    end
  end

  def update
    if current_user.try(:admin?)
      id = params[:id]
      l = Location.find(id)
      l.update(create_update_params)
      if l.save
        flash[:success] = "Location \"#{l.title}\" updated"
        redirect_to location_path(l.id)
      else
        flash[:error] = "Error updating location"
        redirect_to edit_location_path(l.id)
      end
    else
      flash[:warning] = "Invalid permissions"
      redirect_to locations_path and return
    end
  end

  private
  def create_update_params
    params.require(:location).permit(:title, :description, :address, :image)
  end
end


private
  def filter_locations(view_prefs)
    distance = view_prefs["distance_filter"].to_i
    location = view_prefs["location_filter"].to_s.strip
    if(location != "" && distance > 0)
      location=geocode_filter_location(location)
      begin
        if location == [nil, nil]  # Response on a Timeout error.
          raise Geokit::Geocoders::GeocodeError
        end
        @locations=Location.within(distance, :origin => location)  # Can also throw error.
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
