class Conference < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :locations, dependent: :destroy
end
