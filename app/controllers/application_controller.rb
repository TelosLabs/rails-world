class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  default_form_builder ApplicationFormBuilder

  helper_method :current_profile

  private

  def current_profile = current_user&.profile
end
