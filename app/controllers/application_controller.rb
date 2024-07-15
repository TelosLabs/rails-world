class ApplicationController < ActionController::Base
  include Authentication

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render file: Rails.public_path.join("404.html").to_s, status: :not_found, layout: false
  end
end
