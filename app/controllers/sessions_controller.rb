class SessionsController < ApplicationController
  allow_unauthenticated_access

  def index
    @user_session_ids = current_user&.sessions&.pluck(:id)
    @sessions = SessionQuery
      .new(relation: sessions.joins(:location).distinct, params: filter_params).call
      .includes(:location, :tags, speakers: [profile: :image_attachment])
      .order(:starts_at)
  end

  def show
    @user_session_ids = current_user&.sessions&.pluck(:id) || []

    @session = sessions.friendly
      .includes(:location, :tags, speakers: [profile: :image_attachment])
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
    raw = params.permit(:starts_at, :live, :past, :starting_soon).to_h

    if raw["starts_at"].present?
      begin
        raw["starts_at"] = Date.parse(raw["starts_at"]).to_s
      rescue ArgumentError
        raw.delete("starts_at")
      end
    end

    final = raw.compact_blank.merge(show_private: user_signed_in?)

    Rails.logger.info("[Sessions#index] filter_params=#{final.inspect}")

    final
  end
end
