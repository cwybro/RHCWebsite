class Tagging < ApplicationRecord
  belongs_to :location, optional:true
  belongs_to :event, optional:true
  belongs_to :tag, optional:true
end
