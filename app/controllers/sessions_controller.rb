class SessionsController < ApplicationController
  def index
    @sessions = SessionQuery.new(params: filter_params).call
      .includes(:attendees, :location, :speakers, :tags)
  end

  def show
    @session = sessions.find(params[:id])
    @speaker = @session.speakers.first
  end

  private

  def sessions
    @sessions ||= current_conference&.sessions
  end

  def filter_params
    params.permit(:starts_at, :live, :past, :starting_soon)
  end
end
