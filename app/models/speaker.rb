# == Schema Information
#
# Table name: speakers
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Speaker < ApplicationRecord
  has_one :profile, as: :profileable, dependent: :destroy

  has_and_belongs_to_many :events

  accepts_nested_attributes_for :profile

  Profile.delegateable_attributes.each do |attribute|
    delegate attribute, "#{attribute}=", to: :profile, allow_nil: true
  end

  def profile
    super || build_profile
  end
end
