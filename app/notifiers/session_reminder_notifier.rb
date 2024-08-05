class SessionReminderNotifier < ApplicationNotifier
  deliver_by :email do |config|
    config.mailer = "SessionMailer"
    config.method = "reminder"
    config.if = -> { recipient.profile&.mail_notifications }
  end

  deliver_by :webpush, class: "DeliveryMethods::Webpush" do |config|
    config.payload_message = -> {
      {
        title: title,
        body: record.title,
        icon: "/pwa_home_screen_icon.png"
      }
    }
    config.if = -> { recipient.profile&.in_app_notifications }
  end

  notification_methods do
    def title
      if params[:time_before_session].match?(/^0\s/)
        "Starting Now"
      else
        "Starting in about #{params[:time_before_session]}"
      end
    end
  end
end
