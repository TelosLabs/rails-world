class AbuseReportMailer < ApplicationMailer
  def profile_report
    @profile = params[:record]
    @reporter_email = params[:reporter_email]
    @notification = params[:notification]

    mail(
      to: User.admin.pluck(:email),
      subject: @notification&.subject || "Profile Abuse Report"
    )
  end
end
