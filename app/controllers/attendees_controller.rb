class AttendeesController < ApplicationController
  before_action :set_session

  def create
    @session.attendees.push(current_user)
    flash[:notice] = I18n.t("controllers.attendees.add_user.notice")

    session[:last_action] = "create"
    flash[:undo] = {path: undo_session_attendee_path(session_id: @session.id)}

    redirect_back_or_to(sessions_path, params: params[:starts_at])
  end

  def destroy
    @session.attendees.delete(current_user)
    flash[:notice] = I18n.t("controllers.attendees.remove_user.notice")

    session[:last_action] = "destroy"
    flash[:undo] = {path: undo_session_attendee_path(session_id: @session.id)}

    redirect_back_or_to(sessions_path, params: params[:starts_at])
  end

  def undo
    if session[:last_action].present?
      last_action = session[:last_action]

      if last_action == "create"
        @session.attendees.delete(current_user)
      elsif last_action == "destroy"
        @session.attendees.push(current_user)
      end

      session[:last_action] = nil
    else
      flash[:notice] = I18n.t("controllers.attendees.undo.expired")
    end

    redirect_back_or_to(sessions_path, params: params[:starts_at])
  end

  private

  def set_session
    @session = current_conference.sessions.find(params[:session_id])
  end
end
