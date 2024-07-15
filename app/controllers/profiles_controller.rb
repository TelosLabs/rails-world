class ProfilesController < ApplicationController
  include ProfileHelper

  before_action :set_profile, only: [:show, :qr_code]

  def show
  end

  def qr_code
    send_data(
      qr_code_png(@profile),
      filename: "#{@profile.name}.png",
      type: "image/png",
      disposition: "attachment"
    )
  end

  private

  def set_profile
    @profile = Profile.public_profiles.find_by!(uuid: params[:uuid])
  end
end
