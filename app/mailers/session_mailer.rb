class SessionMailer < ApplicationMailer
  helper :datetime

  def reminder
    @recipient = params[:recipient]
    @session = params[:record]
    @speakers = @session.speakers
    @notification = params[:notification]

    mail(to: "andres.alvidrez@teloslabs.co", subject: @notification&.subject)
  end
end
