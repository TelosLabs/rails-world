class SchedulesController < ApplicationController
  def show
    @sessions = current_user.sessions.includes(:attendees, :speakers, :location, :tags)
    @sessions = @sessions.starts_at(params[:starts_at].to_date) if params[:starts_at].present?
  end
end
