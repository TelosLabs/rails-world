class SpeakersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @speaker = current_conference.speakers.friendly.find(params[:id])
    @profile = @speaker.profile.presence || Profile.new
    @sessions = @speaker.sessions
  end
end
