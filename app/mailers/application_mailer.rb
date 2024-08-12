class ApplicationMailer < ActionMailer::Base
  default from: ENV["MAILER_SENDER"]
  layout "mailer"
end
