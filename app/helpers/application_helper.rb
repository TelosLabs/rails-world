module ApplicationHelper
  include Pagy::Frontend

  def current_theme
    cookies[:theme] || "system"
  end

  def resolved_theme_class
    theme = current_theme

    # For server-side rendering, when theme is 'system', we start with no class
    # The inline script will apply the correct theme immediately
    if theme == "system"
      ""
    else
      theme
    end
  end
end
