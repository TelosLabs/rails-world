class SessionMailer < ApplicationMailer
  helper :datetime
  def reminder
    @recipient = params[:recipient]
    @session = params[:record]
    @speakers = @session.speakers
    @notification = params[:notification]
    @subject = reminder_subject

    mail(to: @recipient.email, subject: @subject)
  end

  private

  def reminder_subject
    return t("mailers.session_mailer.reminder.subject.without_time") unless @notification&.params&.dig(:time_before_session)

    t("mailers.session_mailer.reminder.subject.with_time", time_before_session: @notification&.params&.dig(:time_before_session))
  end
end
