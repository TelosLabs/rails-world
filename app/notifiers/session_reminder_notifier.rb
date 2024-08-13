class SessionReminderNotifier < ApplicationNotifier
  deliver_by :email do |config|
    config.mailer = "SessionMailer"
    config.method = "reminder"
    config.if = -> { recipient.profile&.mail_notifications }
  end

  deliver_by :web_push, class: "DeliveryMethods::WebPush" do |config|
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
    include ActionView::Helpers::DateHelper

    def title
      if params[:time_before_session].match?(/^0\s/)
        "Starting Now"
      else
        "Starting in about #{params[:time_before_session]}"
      end
    end

    def delivered_at
      time_difference = distance_of_time_in_words(Time.current, created_at, scope: "date_time.distance_in_words.short")
      (time_difference == "now") ? time_difference : "#{time_difference} ago"
    end
  end
end
