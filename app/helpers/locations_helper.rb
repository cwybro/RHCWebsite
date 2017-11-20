module LocationsHelper
  def geocode_filter_location(location)
    geo=Geokit::Geocoders::MultiGeocoder.geocode (location)
    errors.add(:location, "Could not Geocode filter location") if !geo.success
    return [geo.lat, geo.lng] if geo.success
  end
end
