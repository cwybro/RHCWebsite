class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy
    has_many :events, through: :taggings
    has_many :locations, through: :taggings

end
