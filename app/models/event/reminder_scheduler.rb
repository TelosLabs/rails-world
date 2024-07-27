module Event::ReminderScheduler
  extend ActiveSupport::Concern

  REMINDER_CADENCE = {
    first_reminder: 15.minutes,
    second_reminder: 10.minutes,
    last_reminder: 0.minutes
  }.freeze

  included do
    after_save_commit :schedule_reminder
  end

  private

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
