module ApplicationHelper
  def active_pill_class(session_date = nil)
    if request.params[:on_date] == session_date.to_s || (session_date.blank? && request.params[:on_date].blank?)
      "bg-red text-white"
    else
      "bg-white text-red"
    end
  end

  def show_filters_pills?
    SessionQuery::STATUS_SCOPES.any? { |status| request.params[status] == "1" }
  end
end
