class EventReminderJob < ApplicationJob
  def perform(event_id:, reminder_type:, reminder_id:)
    event = Event.find(event_id)
    return if event.reminder_details["#{reminder_type}_id"] != reminder_id

    EventNotifier.with(record: event, reminder_type: reminder_type).deliver(event.users)
  end
end
