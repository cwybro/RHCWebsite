class Recap < ApplicationRecord
    belongs_to :event
    belongs_to :user
    validates :attendance, :description, presence: true
    validates :attendance, numericality: true
end
