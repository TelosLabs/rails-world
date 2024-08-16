class SessionsController < ApplicationController
  def index
    @user_session_ids = current_user.sessions.pluck(:id)
    @sessions = sessions
      .joins(:speakers, :location)
      .includes(:attendees, :tags)

    @sessions = @sessions.starts_at(params[:starts_at].to_date) if params[:starts_at].present?
  end

  def show
    @session = sessions.find(params[:id])
    @speaker = @session.speakers.first
  end

  private

  def sessions
    current_conference&.sessions
  end
end
