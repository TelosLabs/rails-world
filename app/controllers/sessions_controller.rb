class SessionsController < ApplicationController
  def index
    @sessions = Session.includes(:location, :speakers, :tags)
    @sessions = @sessions.on_date(params[:on_date].to_date) if params[:on_date].present?
  end

  def show
    @session = Session.find(params[:id])
    @speaker = @session.speakers.first
  end
end
