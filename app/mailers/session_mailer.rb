class SessionMailer < ApplicationMailer
  helper :datetime

  def reminder
    @recipient = params[:recipient]
    @session = params[:record]
    @speakers = @session.speakers
    @notification = params[:notification]

    mail(to: @recipient.email, subject: @notification.subject)
  end
end
