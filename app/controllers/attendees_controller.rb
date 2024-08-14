class AttendeesController < ApplicationController
  before_action :set_session

  def create
    if @session.attendees.push(current_user)
      flash[:notice] = I18n.t("controllers.attendees.add_user.notice")
    else
      flash[:alert] = I18n.t("controllers.attendees.add_user.alert")
    end

    redirect_back_or_to(sessions_path, params: params[:starts_at])
  end

  def destroy
    if @session.attendees.delete(current_user)
      flash[:notice] = I18n.t("controllers.attendees.remove_user.notice")
    else
      flash[:alert] = I18n.t("controllers.attendees.remove_user.alert")
    end

    redirect_back_or_to(sessions_path, params: params[:starts_at])
  end

  private

  def set_session
    @session = current_conference.sessions.find(params[:session_id])
  end
end
