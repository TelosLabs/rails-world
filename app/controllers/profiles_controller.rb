class ProfilesController < ApplicationController
  def edit
  end

  def update
    if current_user.profile.nil?
      current_user.profile = Profile.new(profile_params)
      current_user.save!
    else
      current_user.profile.update!(profile_params)
    end
    redirect_to edit_profile_path, notice: "Profile updated!"
  end

  private

  def profile_params
    params.permit(:name, :location, :bio, :is_public, :twitter_url, :linkedin_url, :github_url, :image)
  end
end
