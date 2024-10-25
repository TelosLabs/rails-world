module Onboarding
  extend ActiveSupport::Concern

  included do
    before_action :check_if_registration_is_allowed_or_redirect
  end

  private

  def check_if_registration_is_allowed_or_redirect
    # redirect_to coming_soon_path if Feature.disabled?(:registration)
  end
end
