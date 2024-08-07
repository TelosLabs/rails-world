class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  default_form_builder ApplicationFormBuilder

  helper_method :current_profile, :current_conference

  private

  def current_profile = current_user&.profile

  # TODO: Must change after implementing multi-conference support
  def current_conference = Conference.last
end
