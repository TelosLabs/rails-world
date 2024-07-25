module NavigationHelper
  NAVIGATION_LINKS = {
    agenda: "/",
    schedule: "/",
    profile: "/profile",
    notifications: "/",
    about: "/"
  }

  def nav_icon_class_for(item)
    return "fill-red w-6 h-6" if current_page?(NAVIGATION_LINKS[item])
    "fill-slate-600 w-6 h-6"
  end

  def nav_text_class_for(item)
    return "text-red" if current_page?(NAVIGATION_LINKS[item])
    "text-slate-600"
  end

  # Todo: A better approach would be to support authenticated root and unauthenticated root in routes.rb
  def homepage_link
    user_signed_in? ? root_path : new_session_path
  end
end
