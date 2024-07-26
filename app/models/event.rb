# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  description      :string
#  ends_at          :datetime         not null
#  reminder_details :json
#  starts_at        :datetime         not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  conference_id    :integer          not null
#  location_id      :integer          not null
#
# Indexes
#
#  index_events_on_conference_id  (conference_id)
#  index_events_on_location_id    (location_id)
#
class Event < ApplicationRecord
  REMINDER_CADENCE = 15.minutes

  belongs_to :location
  belongs_to :conference

  has_and_belongs_to_many :speakers
  has_and_belongs_to_many :users # attendees
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  validates_datetime :ends_at, after: :starts_at

  after_save_commit :schedule_reminder

  private

  # TODO: abtract reminder logic
  def schedule_reminder
    return unless should_schedule_reminder?

    reminder_details["15_min_reminder_id"] = SecureRandom.uuid
    save

    deadline = starts_at - REMINDER_CADENCE
    EventReminderJob.set(wait_until: deadline).perform_later(id, reminder_details["15_min_reminder_id"])
  end

  def should_schedule_reminder?
    saved_change_to_starts_at? &&
      Time.zone.now < (starts_at - REMINDER_CADENCE)
  end
end
