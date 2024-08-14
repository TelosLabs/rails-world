class SessionMailer < ApplicationMailer
  helper :datetime
  def reminder
    @recipient = params[:recipient]
    @session = params[:record]
    @speaker = @session.speakers.first
    @notification = params[:notification]
    mail(to: @recipient.email, subject: default_i18n_subject)
  end
end
