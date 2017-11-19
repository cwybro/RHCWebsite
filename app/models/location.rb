class Location < ApplicationRecord
  # validates :title, :latitude, :longitude, presence: true
  validates :title, :address, presence: true

  # acts_as_mappable
  # acts_as_mappable :auto_geocode=>{:field=>:address, :error_message=>'Could not geocode address'}

  acts_as_mappable
  before_validation :geocode_address, :on => :create

  def distance_from(location)
    if location.nil? or location[0].nil? or location[1].nil?
      return Float::INFINITY
    end
    if latitude.nil? or longitude.nil?
      return Float::INFINITY
    end

    lat2 = to_rad location[0]
    lon2 = to_rad location[1]

    lat1 = to_rad latitude
    lon1 = to_rad longitude

    r = 3959
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = (Math.sin(dlat/2.0))**2.0+Math.cos(lat1) * Math.cos(lat2) * (Math.sin(dlon/2.0))**2
    c = 2.0 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = r * c
end

def distance_within?(location, distance)
  if location.is_a? String
    location = geocode(location)
  end
  d = distance_from(location)
  if d.nil?
    false
  else
     d <= distance
  end
end

private
  def geocode_address
    geo=Geokit::Geocoders::MultiGeocoder.geocode (address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

  def to_rad(deg)
    deg/180.0 * Math::PI
  end



  # reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode  # auto-fetch address

  # attr_accessor :address
  #
  # def short_address
  #   if reverse_geocode
  #     parts = reverse_geocode.split(",").map { |x| x.strip }
  #     town = parts[1] || ""
  #     state,zip = *parts[2].split || "", ""
  #     return "#{town}, #{state} - #{zip}"
  #   else
  #     return ""
  #   end
  # end
end
