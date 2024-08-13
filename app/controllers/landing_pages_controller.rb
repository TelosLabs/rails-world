class LandingPagesController < ApplicationController
  allow_unauthenticated_access only: [:show]

  helper_method :show_header?

  def show
  end

  private

  def show_header?
    false
  end
end
