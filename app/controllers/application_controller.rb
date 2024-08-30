class ApplicationController < ActionController::Base
  include Onboarding
  include Authentication
  include Authorization

  default_form_builder ApplicationFormBuilder

  helper_method :current_profile, :current_conference, :vapid_public_key

  rescue_from ActionController::InvalidAuthenticityToken,
    with: :after_invalid_authenticity_token

  private

  def current_profile = current_user&.profile

  def current_conference = Conference.last

  def vapid_public_key
    Base64.urlsafe_decode64(ENV["VAPID_PUBLIC_KEY"]).bytes.to_json
  end

  def after_invalid_authenticity_token
    path_to_redirect = request.referer
    path_to_redirect ||= user_signed_in? ? sessions_path : new_user_session_path
    redirect_to path_to_redirect, alert: t("authorization.invalid_auth_token")
  end
end
