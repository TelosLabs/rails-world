class ProfilesController < ApplicationController
  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    @profile.assign_attributes(profile_params)

    if @profile.save
      remove_profile_image_if_requested
      redirect_to profile_path(@profile.uuid), notice: t("controllers.profiles.update.success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find_by!(uuid: params[:uuid]).decorate
    authorize! @profile, with: ProfilePolicy
  end

  def profile_params
    params.require(:profile).permit(
      :name, :job_title, :bio, :is_public, :image,
      :twitter_url, :linkedin_url, :github_url,
      :in_app_notifications, :mail_notifications
    )
  end

  def remove_profile_image_if_requested
    @profile.image.purge if params[:profile][:remove_image].presence
  end
end
