class ComingSoonsController < ApplicationController
  allow_unauthenticated_access

  skip_before_action :check_if_registration_is_allowed_or_redirect

  def show
  end
end
