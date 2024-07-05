class Speaker < ApplicationRecord
  belongs_to :event

  has_one :profile, as: :profileable
end
