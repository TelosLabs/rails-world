class SessionReminderJob < ApplicationJob
  def perform
    now = Time.zone.now

    Session::REMINDER_CADENCE.each do |reminder_type, cadence|
      starts_at = now + cadence

      Session.where(starts_at: starts_at.beginning_of_minute..starts_at.end_of_minute).find_each do |session|
        SessionReminderNotifier.with(record: session, reminder_type: reminder_type).deliver(session.users)
      end
    end
  end
end
