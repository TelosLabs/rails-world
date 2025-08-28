module ApplicationHelper
  include Pagy::Frontend

  def current_theme
    cookies[:theme] || "dark"
  end
end
