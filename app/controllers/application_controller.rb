class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  helper_method :current_profile

  private

  def current_profile = current_user&.profile
end
