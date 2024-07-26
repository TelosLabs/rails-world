class EventReminderJob < ApplicationJob
  def perform(event_id, reminder_id)
    event = Event.find(event_id)
    return if event.reminder_details["15_min_reminder_id"] != reminder_id

    EventNotifier.with(record: event).deliver(event.users)
  end
end
