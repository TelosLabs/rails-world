module NavigationHelper
  def nav_icon_class_for(path)
    return "fill-red w-6 h-6" if path.any? { |p| current_page?(p) }
    "fill-slate-600 w-6 h-6"
  end

  def nav_text_class_for(path)
    return "text-red" if path.any? { |p| current_page?(p) }
    "text-slate-600"
  end

  # Todo: A better approach would be to support authenticated root and unauthenticated root in routes.rb
  def homepage_link
    user_signed_in? ? root_path : new_session_path
  end
end
