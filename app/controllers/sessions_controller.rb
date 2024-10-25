class SessionsController < ApplicationController
  allow_unauthenticated_access

  def index
    @user_session_ids = current_user&.sessions&.pluck(:id)
    @sessions = SessionQuery
      .new(relation: sessions.joins(:location).distinct, params: filter_params).call
      .includes(:location, :tags)
      .order(:starts_at)
  end

  def show
    @user_session_ids = current_user&.sessions&.pluck(:id) || []

    @session = sessions.friendly
      .includes(:location, :tags)
      .find(params[:id])

    if @session.private? && !user_signed_in?
      session[:after_sign_in_path] = session_path(@session)
      redirect_to new_user_session_path
    end
  end

  private

  def sessions
    Session.where(conference: Current.conference)
  end

  def filter_params
    params.permit(:starts_at, :live, :past, :starting_soon).merge(show_private: user_signed_in?)
  end
end
