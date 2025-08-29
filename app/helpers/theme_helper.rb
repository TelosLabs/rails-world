module ThemeHelper
  def current_theme
    cookies[:theme] || "system"
  end

  def resolved_theme_class
    (current_theme == "dark") ? "dark" : ""
  end
end
