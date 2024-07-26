class EventReminderJob < ApplicationJob
  def perform(event_id, reminder_id)
    event = Event.find(event_id)
    nil if event.reminder_details["15_min_reminder_id"] != reminder_id

    # Call Notfier service
  end
end
