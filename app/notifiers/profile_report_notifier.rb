class ProfileReportNotifier < ApplicationNotifier
  deliver_by :email do |config|
    config.mailer = "AbuseReportMailer"
    config.method = "profile_report"
  end

  notification_methods do
    def subject
      "Profile Report: #{record.name || "Anonymous"} reported by #{params[:reporter_email]}"
    end

    def message
      "Profile '#{record.name || "Anonymous"}' (#{record.uuid}) has been reported for abuse by user #{params[:reporter_email]}."
    end
  end
end
