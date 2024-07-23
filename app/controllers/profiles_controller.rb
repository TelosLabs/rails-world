class ProfilesController < ApplicationController
  before_action :set_profile

  def show
    @profile = @profile.decorate
  end

  private

  def set_profile
    @profile = Profile.public_profiles.find_by!(uuid: params[:uuid])
  end
end
