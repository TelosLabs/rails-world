class ProfilesController < ApplicationController
  before_action :set_profile, only: :show

  def show
    @profile = @profile.decorate
  end

  def edit
    @profile = current_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to profile_path, notice: t("controllers.profiles.create.success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @profile = current_profile
    @profile.assign_attributes(profile_params)

    if @profile.save
      remove_profile_image_if_requested
      redirect_to profile_path, notice: t("controllers.profiles.update.success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.public_profiles.find_by!(uuid: params[:uuid])
  end

  def current_profile
    current_user.profile || current_user.build_profile
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
