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

    def all_tags=(names)
        self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end

    def all_tags
        self.tags.map(|t| t.name).join(", ")
    end

    private

    def timeliness_of_datetime
        errors.add(:datetime, 'must be a valid datetime object') if ((DateTime.parse(datetime.to_s) rescue ArgumentError) == ArgumentError)
    end

end
