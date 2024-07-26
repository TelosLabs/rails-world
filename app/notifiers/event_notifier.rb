class EventNotifier < ApplicationNotifier
  deliver_by :email do |config|
    config.mailer = "EventMailer"
    config.method = "reminder"
    config.params = -> { params }
  end
end
