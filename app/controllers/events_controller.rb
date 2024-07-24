class EventsController < ApplicationController
  def index
    @events = Event.all
    @events = @events.on_date(params[:on_date].to_date) if params[:on_date].present?
  end
end
