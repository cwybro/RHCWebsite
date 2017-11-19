require 'date'

class Event < ApplicationRecord
    has_one :recap, :dependent => :destroy
    validates :title, :description, :address, :datetime, presence: true
    validate :timeliness_of_datetime

    has_attached_file :image,
    :styles=> {:header => "800x400>", :thumb => "100x100>" }
    # no default, use CSS gradient instead.

    validates_attachment :image,
        :content_type => {:content_type => ["image/jpeg", "image/png",]}



    def date
        self.datetime.to_date
    end

    def readable_date
      self.date.strftime("%a, %d %B %Y")
    end

    # Returns the last two comma-seperated items in the address field, excluding zip code.
    # e.g. 100 broad street, Hamilton, NY 13346 -> Hamilton, NY
    def area
      area = self.address.gsub(/\d/, '')
      area = area.strip().split(',')
      if area.length > 2
        return area.slice(area.length - 2, 2).join(',').strip()
      else
        return area.join(',').strip()
      end
    end

    def time
        self.datetime.strftime('%l.%M %p')
    end

    private

    def timeliness_of_datetime
        errors.add(:datetime, 'must be a valid datetime object') if ((DateTime.parse(datetime.to_s) rescue ArgumentError) == ArgumentError)
    end

end
