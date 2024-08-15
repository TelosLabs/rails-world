module SessionHelper
  def active_session_filters?
    (SessionQuery::STATUS_SCOPES & params.keys).any?
  end
end
