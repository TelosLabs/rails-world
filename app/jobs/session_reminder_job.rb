class SessionReminderJob < ApplicationJob
  REMINDER_TIME_BEFORE_EVENT = [10.minutes].freeze

  def perform
    if Feature.disabled?(:session_reminders)
      return Rails.logger.info("Skipping session reminders. Feature is disabled")
    end

    now = Time.zone.now
    Rails.logger.info "Searching for sessions to remind users about. Time is #{now}"

    REMINDER_TIME_BEFORE_EVENT.each do |time_before_session|
      # Grace time is the time window in which we send reminders that should have been sent already.
      grace_time = 2.minutes

      start_reminder_time = (now + time_before_session - grace_time).beginning_of_minute
      end_reminder_time = (start_reminder_time + grace_time).end_of_minute

      Rails.logger.info "Searching for sessions with starts_at between #{start_reminder_time} and #{end_reminder_time}"

      Session.where(starts_at: start_reminder_time..end_reminder_time).find_each do |session|
        next if session.sent_reminders.include?(time_before_session.inspect)

        session.sent_reminders << time_before_session.inspect
        session.sent_reminders.uniq!
        session.save!

        SessionReminderNotifier
          .with(record: session, time_before_session: time_before_session.inspect)
          .deliver(session.attendees)
      end
    end
  end
end
