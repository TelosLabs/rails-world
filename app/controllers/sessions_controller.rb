class SessionsController < ApplicationController
  allow_unauthenticated_access

  def index
    @user_session_ids = current_user&.sessions&.pluck(:id)
    @sessions = SessionQuery.new(
      relation: sessions.joins(:location).distinct,
      params: filter_params
    ).call.includes(:location, :tags, speakers: [profile: :image_attachment]).order(:starts_at)
  end

  def show
    @user_session_ids = current_user&.sessions&.pluck(:id) || []
    @session = if user_signed_in?
      sessions.friendly.includes(:location, :tags, speakers: [profile: :image_attachment]).find(params[:id])
    else
      sessions.publics.friendly.includes(:location, :tags, speakers: [profile: :image_attachment]).find(params[:id])
    end
  end

  private

  def sessions
    Session.where(conference: current_conference)
  end

  def filter_params
    params.permit(:starts_at, :live, :past, :starting_soon).merge(show_private: user_signed_in?)
  end
end
