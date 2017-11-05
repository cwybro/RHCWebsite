require 'date'

class Event < ApplicationRecord
    validates :title, :description, :address, :datetime, presence: true
    validate :timeliness_of_datetime

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    def date
        self.datetime.to_date
    end

    def time
        self.datetime.strfrmt('%l.%M %p')
    end

    private

    def timeliness_of_datetime
        errors.add(:datetime, 'must be a valid datetime object') if ((DateTime.parse(datetime.to_s) rescue ArgumentError) == ArgumentError)
    end

end
