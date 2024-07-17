class PreviewProfilesController < ApplicationController
  def show
    @profile = profile_params
  end

  private

  def profile_params
    params.permit(:name, :location, :bio, :is_public, :twitter_url, :linkedin_url, :github_url, :image)
  end
end
