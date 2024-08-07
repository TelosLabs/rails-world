class SessionsController < ApplicationController
  def index
  end

  def show
    @session = Session.find(params[:id])
    @speaker = @session.speakers.first
  end
end
