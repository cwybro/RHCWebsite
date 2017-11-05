class Location < ApplicationRecord
  validates :title, :latitude, :longitude, presence: true

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
end
