class SchedulesController < ApplicationController
  def show
    @sessions = SessionQuery.new(relation: current_user.sessions.where(conference: current_conference), params: filter_params).call
      .includes(:attendees, :location, :speakers, :tags).order(:starts_at)
  end

  private

  def filter_params
    params.permit(:starts_at, :live, :past, :starting_soon)
  end
end
