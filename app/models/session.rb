# == Schema Information
#
# Table name: sessions
#
#  id             :integer          not null, primary key
#  description    :string
#  ends_at        :datetime         not null
#  sent_reminders :json
#  starts_at      :datetime         not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  conference_id  :integer          not null
#  location_id    :integer          not null
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
  has_and_belongs_to_many :attendees, class_name: "User", join_table: "sessions_users"
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  validates_datetime :ends_at, after: :starts_at

  scope :on_date, ->(date) { where("date(starts_at) = ?", date) }
  scope :past, -> { where(ends_at: ...Time.current) }
  scope :live, -> { where("? BETWEEN starts_at AND ends_at", Time.current) }
  scope :starting_soon, -> { where("starts_at BETWEEN ? and ?", Time.current, 1.hour.from_now) }
  scope :from_user, ->(user) { joins(:attendees).where(attendees: {id: user.id}) }

  after_commit :invalidate_cache

  def self.ransackable_attributes(_auth_object = nil)
    %w[title]
  end

  def live?
    Time.current.between?(starts_at, ends_at)
  end

  private

  def invalidate_cache
    Rails.cache.delete("conference_#{conference_id}_session_dates")
  end
end
