class SessionQuery
  STATUS_SCOPES = %w[live starting_soon past].freeze

  def initialize(relation: Session.all, params: {})
    @relation = relation
    @params = params
  end

  def call
    filter_by_date
    filter_by_status
    filter_privates

    relation
  end

  private

  attr_accessor :relation, :params

  def filter_by_date
    return if starts_at.blank?

    self.relation = relation.where(starts_at: starts_at.all_day)
  end

  def filter_by_status
    self.relation = relation.send_chain_or(status_scopes)
  end

  def filter_privates
    return if params[:show_private].present?

    self.relation = relation.publics
  end

  def starts_at
    @_starts_at ||= params[:starts_at]&.in_time_zone
  rescue Date::Error
    nil
  end

  def status_scopes
    STATUS_SCOPES & params.keys
  end
end
