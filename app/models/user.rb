class User < ApplicationRecord
  has_one :profile, as: :profileable, dependent: :destroy

  has_many :saved_events, dependent: :destroy
  has_many :events, through: :saved_events
end
