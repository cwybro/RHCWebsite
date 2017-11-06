class Location < ApplicationRecord
  validates :title, :latitude, :longitude, presence: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  attr_accessor :address

  def short_address
    if reverse_geocode
      parts = reverse_geocode.split(",").map { |x| x.strip }
      town = parts[1] || ""
      state,zip = *parts[2].split || "", ""
      return "#{town}, #{state} - #{zip}"
    else
      return ""
    end
  end
end
