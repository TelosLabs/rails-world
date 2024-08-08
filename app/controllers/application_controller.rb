class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  default_form_builder ApplicationFormBuilder

  helper_method :current_profile
  helper_method :vapid_public_key

  private

  def current_profile = current_user&.profile

  def vapid_public_key
    return nil if Rails.env.test?

    vapid_key = Rails.application.credentials.dig(:vapid, :public_key)
    Base64.urlsafe_decode64(vapid_key).bytes
  end
end
