# == Schema Information
#
# Table name: locations
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  conference_id :integer          not null
#
# Indexes
#
#  index_locations_on_conference_id           (conference_id)
#  index_locations_on_name_and_conference_id  (name,conference_id) UNIQUE
#
class Location < ApplicationRecord
  belongs_to :conference

  has_many :sessions, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: {scope: :conference_id}

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
