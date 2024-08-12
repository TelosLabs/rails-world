class SessionsController < ApplicationController
  def index
    @sessions = SessionQuery.new(
      params: filter_params,
      includes: [:location, :speakers, :tags]
    ).call
  end

  def show
    @session = Session.find(params[:id])
    @speaker = @session.speakers.first
  end

  def update
    @session = Session.find(params[:id])

    @session.attendees.include?(current_user) ? remove_user_from_session : add_user_to_session

    redirect_to sessions_path(on_date: params[:on_date])
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

  def filter_params
    params.permit(:on_date, :live, :past, :starting_soon)
  end
end
