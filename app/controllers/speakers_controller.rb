class SpeakersController < ApplicationController
  def show
    @speaker = Speaker.find(params[:id])
    @profile = @speaker.profile.presence || Profile.new
    @sessions = @speaker.sessions
  end
end
