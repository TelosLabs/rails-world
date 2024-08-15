class SpeakersController < ApplicationController
  def show
    @speaker = current_conference.speakers.find(params[:id])
    @profile = @speaker.profile.presence || Profile.new
    @sessions = @speaker.sessions
  end
end
