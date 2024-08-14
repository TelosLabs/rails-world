module SessionHelper
  def active_filters?
    (SessionQuery::STATUS_SCOPES & params.keys).any?
  end
end
