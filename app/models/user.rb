class User < ApplicationRecord
  has_one :profile, as: :profileable

  has_many :saved_events
  has_many :events, through: :saved_events
end
