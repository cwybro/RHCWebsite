class Location < ApplicationRecord
  validates :title, :latitude, :longitude, presence: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  def address
    Geocoder.address("#{latitude}, #{longitude}") || ""
  end
end
