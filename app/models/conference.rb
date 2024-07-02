class Conference < ApplicationRecord
  has_many :events
  has_many :locations
end
