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
end
