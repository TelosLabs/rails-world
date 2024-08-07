class SessionMailer < ApplicationMailer
  def reminder
    recipient = params[:recipient]

    mail(to: recipient.email)
  end
end
