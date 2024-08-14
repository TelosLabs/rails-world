class SessionQuery
  STATUS_SCOPES = %i[live starting_soon past].freeze

  def initialize(relation: Session.all, params: {}, includes: {})
    @relation = relation
    @params = params.to_h.symbolize_keys
    @includes = includes
  end

  def call
    filter_by_date
    filter_by_status
    assign_includes

    relation
  end

  private

  attr_accessor :relation, :params, :includes

  def filter_by_date
    return if starts_at.blank?

    self.relation = relation.starts_at(starts_at)
  end

  def filter_by_status
    self.relation = relation.send_chain_or(status_scopes)
  end

  def starts_at
    @_starts_at ||= params[:starts_at]&.to_date
  rescue Date::Error
    nil
  end

  def status_scopes
    STATUS_SCOPES & params.select { |_, v| v == "1" }.keys
  end

  def assign_includes
    return if includes.empty?

    self.relation = relation.includes(*includes)
  end
end
