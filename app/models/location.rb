class Location < ApplicationRecord
  validates :title, :description, :address, presence: true

  has_attached_file :image,
  :styles=> {:header => "800x400#", :thumb => "100x100#", :grid => "300x200#" }
  # no default, use CSS gradient instead.

  validates_attachment :image,
      :content_type => {:content_type => ["image/jpeg", "image/png",]}


  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # acts_as_mappable
  # acts_as_mappable :auto_geocode=>{:field=>:address, :error_message=>'Could not geocode address'}

  acts_as_mappable
  before_validation :geocode_address, :on => [:create, :save]


private
  def geocode_address
    geo=Geokit::Geocoders::GoogleGeocoder.geocode (address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
end
