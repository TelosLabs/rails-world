class SessionsController < ApplicationController
  def index
    @user_session_ids = current_user.sessions.pluck(:id)
    @sessions = SessionQuery.new(
      relation: sessions.joins(:location).distinct,
      params: filter_params
    ).call.includes(:location, :tags, speakers: [profile: :image_attachment]).order(:starts_at)
  end

  def show
    @session = sessions.friendly.includes(:location, :tags, speakers: [profile: :image_attachment]).find(params[:id])
  end

  private

  def sessions
    current_conference&.sessions
  end

  def filter_params
    params.permit(:starts_at, :live, :past, :starting_soon)
  end
end
