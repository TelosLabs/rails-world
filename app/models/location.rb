class Location < ApplicationRecord
  belongs_to :conference

  has_many :sessions, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: {scope: :conference_id}

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
