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

  def current_day_anchor(session_date)
    return "" if session_date != Date.current

    "#" + session_anchor(current_agenda_session)
  end

  def current_starts_at_filter
    return unless current_conference

    (current_conference.sessions.starts_at(Date.current).first || current_conference.sessions.order(:starts_at).first)&.starts_at&.to_date
  end

  def current_agenda_session
    @_current_agenda_session ||= current_conference&.sessions&.upcoming_today&.first
  end

  def current_schedule_session
    @_current_schedule_session ||= current_user.sessions.upcoming_today.first
  end
end
