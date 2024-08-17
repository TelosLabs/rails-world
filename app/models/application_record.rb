class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def send_chain_or(scopes)
      return all if scopes.blank?

      base_scope = none

      scopes.each do |scope_name|
        scope_to_add = send(scope_name)
        base_scope = (base_scope == none) ? scope_to_add : base_scope.or(scope_to_add)
      end

      base_scope
    end
  end
end
