class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  default_form_builder ApplicationFormBuilder

  helper_method :current_profile, :current_conference, :vapid_public_key

  before_action :redirect_to_landing_page

  private

  def current_profile = current_user&.profile

  # TODO: Must change after implementing multi-conference support
  def current_conference = Conference.last

  def vapid_public_key
    Base64.urlsafe_decode64(ENV["VAPID_PUBLIC_KEY"]).bytes.to_json
  end

  def redirect_to_landing_page
    if Feature.enabled?(:landing_page) && request.path != landing_page_path
      redirect_to landing_page_path
    end
  end
end
