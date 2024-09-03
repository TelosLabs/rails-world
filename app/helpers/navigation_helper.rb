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
  def show_bottom_navbar?
    current_page?(sessions_path) ||
      (user_signed_in? || !current_page?(unauthenticated_root_path)) &&
        !excluded_paths.any? { |path| current_page?(path) }
  end
  
  private
  
  def excluded_paths
    [
      new_user_session_path,
      new_registration_path,
      new_password_reset_path,
      edit_password_reset_path,
      post_submit_password_reset_path
    ]
  end
  end

  def title(title)
    content_for :title, title
  end
end
