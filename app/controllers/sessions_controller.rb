class SessionsController < ApplicationController
  def index
    @sessions = Session.all
    @sessions = @sessions.on_date(params[:on_date].to_date) if params[:on_date].present?
  end
end
