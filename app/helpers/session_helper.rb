module SessionHelper
  def active_filters?
    SessionQuery::STATUS_SCOPES.any? { |status| request.params[status] == "1" }
  end
end
