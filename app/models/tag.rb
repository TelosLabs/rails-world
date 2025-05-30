class Tag < ApplicationRecord
  has_and_belongs_to_many :sessions

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
