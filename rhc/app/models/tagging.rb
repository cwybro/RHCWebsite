class Tagging < ApplicationRecord
  belongs_to :event
  belongs_to :location
  belongs_to :tag
end
