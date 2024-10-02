class AttendeesController < ApplicationController
  before_action :set_session

  def create
    @session.attendees.push(current_user) if @session.attendees.exclude?(current_user)
    @user_session_ids = current_user.sessions.pluck(:id)
  end

  def destroy
    @session.attendees.delete(current_user) if @session.attendees.include?(current_user)
    @user_session_ids = current_user.sessions.pluck(:id)
    if URI(request.referer).path == schedule_path
      flash[:notice] = I18n.t("controllers.attendees.remove_user.notice")
      redirect_back_or_to(sessions_path, params: params[:starts_at])
    end
  end

  private

  def set_session
    @session = Current.conference.sessions.find(params[:session_id])
  end
end
