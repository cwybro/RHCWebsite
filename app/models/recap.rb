class Recap < ApplicationRecord
    belongs_to :event
    validates :attendance, :description, :event_id, presence: true
    validates :is_reviewed, inclusion: { in: [ true, false ] }
    validates :attendance, numericality: true
end
