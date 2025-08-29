module NavigationHelper
  def nav_icon_class_for(paths)
    if paths.any? { |p| active_path?(p) }
      "fill-red w-6 h-6 dark:fill-white"
    else
      "fill-grey-400 w-6 h-6"
    end
  end

  def nav_text_class_for(paths)
    if paths.any? { |p| active_path?(p) }
      "text-red dark:text-lightcolor"
    else
      "text-grey-400"
    end
  end

  def active_path?(path)
    return request.path == path if root_path == path

    request.path.starts_with?(path)
  end

  def title(title)
    content_for :title, title
  end

  def back_title
    if controller_name.include?("_")
      controller_name.humanize
    else
      "#{controller_name.singularize.capitalize} detail"
    end
  end

  def show_bookmark_button?(session)
    controller_name == "schedules" || !session.past?
  end
end
