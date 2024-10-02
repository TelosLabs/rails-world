class PasswordMailer < ApplicationMailer
  def password_reset
    mail(to: params[:user].email, subject: I18n.t("mailers.password_mailer.password_reset.subject", conference_name: Current.conference&.name))
  end
end
