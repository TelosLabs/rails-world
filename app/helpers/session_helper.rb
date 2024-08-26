module SessionHelper
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

  def session_filter_params
    params.permit(SessionQuery::STATUS_SCOPES)
  end

  def session_anchor(session)
    return unless session

    session.starts_at&.strftime("%Y-%m-%d-%H-%M")
  end
end
