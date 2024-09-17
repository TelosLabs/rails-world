class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def self.conference
    @_current_conference ||= Conference.last
  end
end
