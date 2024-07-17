module NavigationHelper
  NAVIGATION_LINKS = {
    agenda: "/",
    schedule: "/",
    profile: "/profile",
    notifications: "/",
    about: "/"
  }

  def nav_icon_class_for(item)
    return "fill-red-500 w-6 h-6" if current_page?(NAVIGATION_LINKS[item])
    "fill-slate-600 w-6 h-6"
  end

  def nav_text_class_for(item)
    return "text-red-500" if current_page?(NAVIGATION_LINKS[item])
    "text-slate-600"
  end
end
