# == Schema Information
#
# Table name: conferences
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Conference < ApplicationRecord
  has_many :locations, dependent: :restrict_with_error
  has_many :sessions, dependent: :restrict_with_error

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
