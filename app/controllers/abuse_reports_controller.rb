class AbuseReportsController < ApplicationController
  allow_unauthenticated_access

  before_action :set_profile

  def create
    reporter_email = current_user&.email || "anonymous"

    ProfileReportNotifier.with(record: @profile, reporter_email: reporter_email).deliver_later(User.admin)

    render turbo_stream: turbo_stream.replace(
      "flash_message",
      partial: "layouts/flash_message",
      locals: {message: t("controllers.abuse_reports.create.success")}
    )
  end

  private

  def set_profile
    @profile = Profile.find_by!(uuid: params[:uuid]).decorate
  end
end
