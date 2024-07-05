class Event < ApplicationRecord
  belongs_to :location
  belongs_to :conference

  has_many :event_tags, dependent: :destroy
  has_many :saved_events, dependent: :destroy
  has_many :speakers, dependent: :destroy
  has_many :tags, through: :event_tags
  has_many :users, through: :saved_events
end
