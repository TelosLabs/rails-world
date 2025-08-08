class ProfilesController < ApplicationController
  allow_unauthenticated_access only: :show

  before_action :set_profile, except: :show

  def show
    if user_signed_in?
      @profile = Profile.find_by!(uuid: params[:uuid]).decorate
      authorize! @profile, with: ProfilePolicy, to: :show?
    else
      render :guest, status: :ok
    end
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

  def destroy
    if @profile.profileable.destroy
      redirect_to new_user_session_path, notice: t("controllers.profiles.destroy.success")
    else
      redirect_to profile_path(@profile.uuid), alert: t("controllers.profiles.destroy.error")
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
      :web_push_notifications, :mail_notifications
    )
  end

  def remove_profile_image_if_requested
    @profile.image.purge if params[:profile][:remove_image].presence
  end
end
