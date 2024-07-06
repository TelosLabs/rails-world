class Profile < ApplicationRecord
  belongs_to :profileable, polymorphic: true

  has_one :self_ref, class_name: "Profile", foreign_key: :id, inverse_of: :self_ref, dependent: :destroy
  has_one :user, through: :self_ref, source: :profileable, source_type: "User"
  has_one :speaker, through: :self_ref, source: :profileable, source_type: "Speaker"
end
