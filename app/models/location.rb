class Location < ApplicationRecord
  # validates :title, :latitude, :longitude, presence: true
  validates :title, :description, :address, presence: true

  has_attached_file :image,
  :styles=> {:header => "800x400#", :thumb => "100x100#" }
  # no default, use CSS gradient instead.

  validates_attachment :image,
      :content_type => {:content_type => ["image/jpeg", "image/png",]}
      
  acts_as_mappable
  before_validation :geocode_address, :on => [:create, :save]


private
  def geocode_address
    geo=Geokit::Geocoders::GoogleGeocoder.geocode (address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
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
