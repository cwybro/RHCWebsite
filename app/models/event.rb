require 'date'

class Event < ApplicationRecord
    has_one :recap, :dependent => :destroy
    belongs_to :user
    validates :title, :description, :address, :datetime, :user_id, presence: true
    validates :is_reviewed, inclusion: { in: [ true, false ] }
    validate :timeliness_of_datetime
    scope :today, -> { where('datetime > ? AND datetime < ?', DateTime.current().beginning_of_day, DateTime.current().end_of_day) }
    scope :future, -> { where('datetime > ?', DateTime.current().beginning_of_day) }
    scope :featured_events, -> {where('featured = ?', true)}
    ###scope :future_featured, -> { where('datetime > ? AND featured = ?', DateTime.current().beginning_of_day) }
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    has_attached_file :image,
    :styles=> {:header => "800x400#", :grid => "300x200#" }
    # no default, use CSS gradient instead.

    validates_attachment :image,
        :content_type => {:content_type => ["image/jpg", "image/jpeg", "image/png",]}


    def date
      self.datetime.to_date
    end

    def readable_date
      self.date.strftime("%a, %d %B %Y")
    end

    def days_until(ref)
      if ref
        days = ((self.datetime - ref) / 3600.0 / 24.0)

        case days
        when -(1.0/0)...0
          "Passed"
        when 0...1
          "Today"
        when 1...2
          "Tomorrow"
        when 2...21
          "#{days.round} days"
        else
          month = self.date.strftime("%B")
          "#{month} #{self.date.day}"
        end
      end
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

    def self.tagged_with(id)
      Tag.find_by_id(id).events
    end

    private

    def timeliness_of_datetime
        errors.add(:datetime, 'must be a valid datetime object') if ((DateTime.parse(datetime.to_s) rescue ArgumentError) == ArgumentError)
    end
end
