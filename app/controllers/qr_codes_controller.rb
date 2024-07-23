class QRCodesController < ApplicationController
  before_action :set_profile

  def show
    @profile = @profile.decorate

    send_data(
      @profile.png_qr_code(size: 240),
      filename: "qr.png",
      type: "image/png",
      disposition: "attachment"
    )
  end

  private

  def set_profile
    @profile = Profile.public_profiles.find_by!(uuid: params[:profile_uuid])
  end
end
