class AttendeesController < ApplicationController
  before_action :set_session

  def create
    @session.attendees.push(current_user)
    flash[:notice] = I18n.t("controllers.attendees.add_user.notice")

    session[:last_action] = {action: "create", user_id: current_user.id, session_id: @session.id}
    flash[:undo_path] = undo_session_attendee_path(session_id: @session.id)

    redirect_back_or_to(sessions_path, params: params[:starts_at])
  end

  def destroy
    @session.attendees.delete(current_user)
    flash[:notice] = I18n.t("controllers.attendees.remove_user.notice")

    session[:last_action] = {action: "destroy", user_id: current_user.id, session_id: @session.id}
    flash[:undo_path] = undo_session_attendee_path(session_id: @session.id)

    redirect_back_or_to(sessions_path, params: params[:starts_at])
  end

  def undo
    binding.pry
    redirect_back_or_to(sessions_path, params: params[:starts_at])
  end

  private

  def set_session
    @session = current_conference.sessions.find(params[:session_id])
  end
end
