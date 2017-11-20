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
    @locations=Location.all
    logger.debug(view_prefs.inspect)
    distance = view_prefs["distance_filter"].to_i
    location = view_prefs["location_filter"].to_s.strip

    if location != "" && distance > 0
      lat, lon = geocode_filter_location(location)
      logger.debug("Location filt #{location}, #{lat}, #{lon}")
      if !lat.nil? && !lon.nil?
        @locations = @locations.select {|l| l.distance_within?([lat,lon], distance)}
      end
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
