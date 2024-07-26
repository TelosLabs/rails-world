class EventNotifier < ApplicationNotifier
  deliver_by :email do |config|
    config.mailer = "EventMailer"
    config.method = "reminder"
    config.params = -> { params }
  end

  notification_methods do
    def time_to_start_message
      cadence = Event::REMINDER_CADENCE.fetch(params[:reminder_type])

      if params[:reminder_type] == :last_reminder
        "Starting Now"
      else
        "Starting in #{cadence} minutes"
      end
    end
  end
end
