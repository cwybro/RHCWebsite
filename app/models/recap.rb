class Recap < ApplicationRecord
    belongs_to :event
    validates :attendance, :description, presence: true
    validates :attendance, numericality: true
end
