class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  default_form_builder ApplicationFormBuilder

  helper_method :current_profile, :vapid_public_key

  private

  def current_profile = current_user&.profile

  def vapid_public_key
    Base64.urlsafe_decode64(ENV["VAPID_PUBLIC_KEY"]).bytes.to_json
  end
end
