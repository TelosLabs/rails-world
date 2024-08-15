class SchedulesController < ApplicationController
  def show
    @sessions = current_user.sessions
      .where(conference: current_conference)
      .includes(:attendees, :speakers, :location, :tags)

    @sessions = @sessions.starts_at(params[:starts_at].to_date) if params[:starts_at].present?
  end
end
