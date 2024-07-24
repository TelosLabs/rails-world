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
  belongs_to :location
  belongs_to :conference

  has_and_belongs_to_many :speakers
  has_and_belongs_to_many :users # attendees
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  validates_datetime :ends_at, after: :starts_at

  # this scope returns events based on a given date
  scope :on_date, ->(date) { where(starts_at: date.all_day) }
end
