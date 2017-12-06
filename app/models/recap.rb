class Recap < ApplicationRecord
    belongs_to :event
    validates :attendance, :description, :event_id, presence: true
    validates :attendance, numericality: true
end
