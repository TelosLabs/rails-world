class QRCodesController < ApplicationController
  include ProfileHelper

  before_action :set_profile

  def show
    send_data(
      qr_code_png(@profile),
      filename: "#{@profile.name}.png",
      type: "image/png",
      disposition: "attachment"
    )
  end

  private

  def set_profile
    @profile = Profile.public_profiles.find_by!(uuid: params[:profile_uuid])
  end
end
