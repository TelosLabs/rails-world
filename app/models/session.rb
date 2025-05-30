class Session < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged

  has_rich_text :description

  belongs_to :location
  belongs_to :conference

  has_and_belongs_to_many :speakers
  has_and_belongs_to_many :attendees, class_name: "User", join_table: "sessions_users"
  has_and_belongs_to_many :tags

  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"

  validates :title, presence: true
  validates :slug, uniqueness: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  validates_datetime :ends_at, after: :starts_at

  scope :starts_at, ->(date) { where(starts_at: date.all_day) }
  scope :past, -> { where(ends_at: ...Time.current) }
  scope :live, -> { where("? BETWEEN starts_at AND ends_at", Time.current) }
  scope :starting_soon, -> { where("starts_at BETWEEN ? AND ?", Time.current, 1.hour.from_now) }
  scope :upcoming_today, -> { where("date(starts_at) = ? AND starts_at > ?", Date.current, Time.current) }
  scope :live_or_upcoming_today, -> { live.or(upcoming_today) }
  scope :publics, -> { where(public: true) }
  scope :privates, -> { where(public: false) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[title]
  end

  def live?
    Time.current.between?(starts_at, ends_at)
  end

  def starting_soon?
    return false if starts_at < Time.current

    (starts_at - Time.current) <= 1.hour
  end

  def past?
    ends_at < Time.current
  end

  def private?
    !public?
  end
end
