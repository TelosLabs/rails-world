class SchedulesController < ApplicationController
  def show
    @sessions = SessionQuery.new(params: filter_params).call
      .includes(:attendees, :location, :speakers, :tags)
  end

  private

  def filter_params
    params.permit(:starts_at, :live, :past, :starting_soon)
  end
end
