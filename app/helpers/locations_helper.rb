module LocationsHelper
  def geocode_filter_location(location)
    geo=Geokit::Geocoders::MultiGeocoder.geocode (location)
    if !geo.success
      return [nil, nil]
    end
    return [geo.lat, geo.lng] if geo.success
  end
end
