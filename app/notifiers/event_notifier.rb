class EventNotifier < ApplicationNotifier
  deliver_by :email do |config|
    config.mailer = "EventMailer"
    config.method = "reminder"
    config.if = -> { recipient.profile&.mail_notifications }
  end

  deliver_by :webpush, class: "DeliveryMethods::Webpush" do |config|
    config.payload_message = -> {
      {
        title: time_to_start_message,
        body: record.title,
        icon: recipient.profile&.image.present? ? url_for(recipient.profile.image) : nil
      }
    }
    config.if = -> { recipient.profile&.in_app_notifications }
  end

  notification_methods do
    def time_to_start_message
      cadence = Event::REMINDER_CADENCE.fetch(params[:reminder_type])

      if params[:reminder_type] == :last_reminder
        "Starting Now"
      else
        "Starting in about #{cadence} minutes"
      end
    end
  end
end
