class Location < ApplicationRecord
  validates :title, :latitude, :longitude, presence: true
end
