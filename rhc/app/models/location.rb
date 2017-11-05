class Location < ApplicationRecord
  validates :title, :latitude, :longitude, presence: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  attr_accessor :address
end
