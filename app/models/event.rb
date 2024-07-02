class Event < ApplicationRecord
  belongs_to :location
  belongs_to :conference

  has_many :event_tags
  has_many :saved_events
  has_many :speakers
  has_many :tags, through: :event_tags
  has_many :users, through: :saved_events
end
