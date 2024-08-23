class SessionMailer < ApplicationMailer
  helper :datetime
  def reminder
    @recipient = params[:recipient]
    @session = params[:record]
    @speakers = @session.speakers

    mail(to: @recipient.email, subject: t("mailers.session_mailer.reminder.subject"))
  end
end
