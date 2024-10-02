class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :conference, default: -> { Conference.last }
end
