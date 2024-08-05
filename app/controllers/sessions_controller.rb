class SessionsController < ApplicationController
  def index
    @sessions = Session.includes(:location, :speakers, :tags)
    @sessions = @sessions.on_date(params[:on_date].to_date) if params[:on_date].present?
  end

  def update
    @session = Session.find(params[:id])

    if @session.update(users: [current_user])
      flash[:notice] = I18n.t("sessions.update.notice")
    else
      flash[:alert] = I18n.t("sessions.update.alert")
    end

    redirect_to sessions_path(on_date: params[:on_date])
  end
end
