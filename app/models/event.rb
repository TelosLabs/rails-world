# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  description   :string
#  ends_at       :datetime         not null
#  starts_at     :datetime         not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  conference_id :integer          not null
#  location_id   :integer          not null
#
# Indexes
#
#  index_events_on_conference_id  (conference_id)
#  index_events_on_location_id    (location_id)
#
class Event < ApplicationRecord
  REMINDER_CADENCE = {
    first_reminder: 15.minutes,
    second_reminder: 10.minutes,
    last_reminder: 0.minutes
  }.freeze

  belongs_to :location
  belongs_to :conference

  has_and_belongs_to_many :speakers
  has_and_belongs_to_many :users # attendees
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  validates_datetime :ends_at, after: :starts_at
end
