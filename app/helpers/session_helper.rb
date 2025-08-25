module SessionHelper
  def session_filter_color(scope)
    case scope
    when "live"
      "bg-green-500 dark:bg-opacity-20"
    when "past"
      "bg-bluegray-200 dark:bg-[#182027]"
    when "starting_soon"
      "bg-yellow dark:bg-[#e2943a33]"
    end
  end

  def session_filter_icon_color(scope)
    case scope
    when "live"
      "bg-green-500"
    when "past"
      "bg-bluegray-200"
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

  def current_day_anchor(session_date)
    return "" if session_date != Date.current || current_agenda_session.blank?

    "#" + session_anchor(current_agenda_session)
  end

  def current_starts_at_filter
    return unless Current.conference

    Current.conference.sessions.starts_at(Date.current).first&.starts_at&.to_date
  end

  def current_agenda_session
    @current_agenda_session ||= Current.conference&.sessions&.live_or_upcoming_today&.first
  end

  def current_schedule_session
    @current_schedule_session ||= current_user&.sessions&.live_or_upcoming_today&.first
  end
end
