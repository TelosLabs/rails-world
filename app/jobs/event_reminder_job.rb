class EventReminderJob < ApplicationJob
  def perform
    now = Time.zone.now

    Event::REMINDER_CADENCE.each do |reminder_type, cadence|
      starts_at = now + cadence

      Event.where(starts_at: starts_at.beginning_of_minute..starts_at.end_of_minute).find_each do |event|
        EventNotifier.with(record: event, reminder_type: reminder_type).deliver(event.users)
      end
    end
  end
end
