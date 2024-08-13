class SchedulesController < ApplicationController
  def index
    @sessions = Session.includes(:location, :speakers, :tags)
    @sessions = @sessions.from_user(current_user)
    @sessions = @sessions.on_date(params[:on_date].to_date) if params[:on_date].present?
  end
end
