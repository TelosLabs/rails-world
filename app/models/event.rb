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

  after_save_commit :schedule_reminder

  private

  # TODO: abtract reminder logic
  def schedule_reminder
    return unless saved_change_to_starts_at?

    REMINDER_CADENCE.each do |reminder_type, cadence|
      deadline = starts_at - cadence
      next unless deadline > Time.zone.now

      reminder_id = SecureRandom.uuid
      reminder_details["#{reminder_type}_id"] = reminder_id
      save

      EventReminderJob
        .set(wait_until: deadline)
        .perform_later(
          event_id: id,
          reminder_type: reminder_type,
          reminder_id: reminder_id
        )
    end
  end
end
