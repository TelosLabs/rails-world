class SessionReminderJob < ApplicationJob
  def perform
    now = Time.zone.now
    Session::REMINDER_TIME_BEFORE_EVENT.each do |time_before_session|
      reminder_time = now + time_before_session
      two_iterations_ago = now - 2.minutes

      Session
        .where(starts_at: two_iterations_ago.beginning_of_minute..reminder_time.end_of_minute)
        .find_each do |session|
        next if session.reminder_details["delivered_reminder_times"]&.include?(time_before_session.inspect)

        SessionReminderNotifier
          .with(record: session, time_before_session: time_before_session.inspect)
          .deliver(session.users.with_at_least_one_notification_enabled)

        session.reminder_details["delivered_reminder_times"] ||= []
        session.reminder_details["delivered_reminder_times"] << time_before_session.inspect
        session.save!
      end
    end
  end
end
