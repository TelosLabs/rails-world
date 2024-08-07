module NavigationHelper
  def nav_icon_class_for(path)
    return "fill-secondary-500 stroke-secondary-500 w-6 h-6" if path.any? { |p| current_page?(p) }
    "fill-gray-5 stroke-gray-5 w-6 h-6"
  end

  def nav_text_class_for(path)
    return "text-secondary-500" if path.any? { |p| current_page?(p) }
    "text-gray-5"
  end

  def show_header?
    !current_page?(new_user_session_path) && !current_page?(about_path)
  end

  # Todo: A better approach would be to support authenticated root and unauthenticated root in routes.rb
  def homepage_link
    user_signed_in? ? root_path : new_user_session_path
  end
end
