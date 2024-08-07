class SchedulesController < ApplicationController
  def index
    @sessions = Session.includes(:location, :speakers, :tags)
    @sessions = @sessions.from_user(current_user)
    @sessions = @sessions.on_date(params[:on_date].to_date) if params[:on_date].present?
  end

  def update
    @session = Session.find(params[:id])

    @session.attendees.include?(current_user) ? remove_user_from_session : add_user_to_session

    redirect_to schedules_path(on_date: params[:on_date])
  end

  private

  def remove_user_from_session
    if @session.attendees.delete(current_user)
      flash[:notice] = I18n.t("controllers.sessions.remove_user.notice")
    else
      flash[:alert] = I18n.t("controllers.sessions.remove_user.alert")
    end
  end

  def add_user_to_session
    if @session.attendees.push(current_user)
      flash[:notice] = I18n.t("controllers.sessions.add_user.notice")
    else
      flash[:alert] = I18n.t("controllers.sessions.add_user.alert")
    end
  end
end
