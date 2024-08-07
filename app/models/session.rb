# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  description   :string
#  ends_at       :datetime         not null
#  starts_at     :datetime         not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  conference_id :integer          not null
#  location_id   :integer          not null
#
# Indexes
#
#  index_sessions_on_conference_id  (conference_id)
#  index_sessions_on_location_id    (location_id)
#
class Session < ApplicationRecord
  belongs_to :location
  belongs_to :conference

  has_and_belongs_to_many :speakers
  has_and_belongs_to_many :users # attendees
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  validates_datetime :ends_at, after: :starts_at

  scope :on_date, ->(date) { where(starts_at: date.all_day) }

  after_commit :invalidate_cache

  def self.ransackable_attributes(_auth_object = nil)
    %w[title]
  end

  private

  def invalidate_cache
    Rails.cache.delete("conference_#{conference_id}_session_dates")
  end
end
