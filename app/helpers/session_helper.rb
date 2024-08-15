module SessionHelper
  def active_session_filters?
    (SessionQuery::STATUS_SCOPES & params.keys).any?
  end

  def session_filter_color(scope)
    case scope
    when "live"
      "bg-green-500"
    when "past"
      "bg-blue-teal-light"
    when "starting_soon"
      "bg-yellow"
    end
  end
end
