class ProfilesController < ApplicationController
  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.profile || Profile.new
  end

  def update
    if current_user.profile.nil?
      current_user.profile = Profile.new(profile_params)
      current_user.save!
    else
      current_user.profile.update!(profile_params)
    end
    current_user.update!(notifications_params)
    redirect_to profile_path, notice: t("controllers.profiles.update.success")
  end

  private

  def profile_params
    params.permit(:name, :location, :bio, :is_public, :twitter_url, :linkedin_url, :github_url, :image)
  end

  def notifications_params
    params.permit(:in_app_notifications_enabled, :mail_notifications_enabled)
  end
end
