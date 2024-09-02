module NavigationHelper
  def nav_icon_class_for(paths)
    return "fill-red w-6 h-6" if paths.any? { |p| active_path?(p) }
    "fill-grey-400 w-6 h-6"
  end

  def nav_text_class_for(paths)
    return "text-red" if paths.any? { |p| active_path?(p) }
    "text-grey-400"
  end

  def active_path?(path)
    return request.path == path if root_path == path

    request.path.starts_with?(path)
  end

  def show_header?
    !current_page?(new_user_session_path) &&
      !current_page?(about_path) &&
      !current_page?(coming_soon_path)
  end

  def show_bottom_navbar?
    user_signed_in? &&
      !current_page?(coming_soon_path) &&
      !error_page?
  end

  def show_back_button?
    current_page?(notification_settings_path) ||
      resource_show_page?("speakers") ||
      resource_show_page?("sessions")
  end

  def back_title
    if controller_name.include?("_")
      controller_name.humanize
    else
      "#{controller_name.singularize.capitalize} detail"
    end
  end

  def title(title)
    content_for :title, title
  end

  private

  def resource_show_page?(resource)
    controller_name == resource && action_name == "show"
  end

  def error_page?
    ["/404", "/500"].include?(request.path)
  end
end
