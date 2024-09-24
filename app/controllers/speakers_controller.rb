class SpeakersController < ApplicationController
  allow_unauthenticated_access only: [:show]
  def show
    @speaker = current_conference.speakers.friendly.find(params[:id])
    @profile = @speaker.profile.presence || Profile.new
    @sessions = @speaker.sessions
  end
end
