class SessionsController < ApplicationController
  def index
    @sessions = sessions.includes(:attendees, :speakers, :location, :tags)
    @sessions = @sessions.starts_at(params[:starts_at].to_date) if params[:starts_at].present?
  end

  def show
    @session = sessions.find(params[:id])
    @speaker = @session.speakers.first
  end

  private

  def sessions
    @sessions ||= current_conference&.sessions
  end
end
