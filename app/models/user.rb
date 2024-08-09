# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  PASSWORD_RESET_EXPIRATION = 60.minutes

  has_secure_password

  normalizes :email, with: ->(email) { email.strip.downcase }

  enum role: {user: "user", admin: "admin"}

  has_one :profile, as: :profileable, dependent: :destroy

  has_and_belongs_to_many :sessions

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  has_many :web_push_subscriptions, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password_digest, presence: true
  validates :password, length: {minimum: 8}, if: -> { password.present? }

  after_create_commit { create_profile! }

  accepts_nested_attributes_for :profile

  scope :with_at_least_one_notification_enabled, -> {
    joins(:profile).where("profiles.in_app_notifications = ? OR profiles.mail_notifications = ?", true, true)
  }

  generates_token_for :password_reset, expires_in: PASSWORD_RESET_EXPIRATION do
    password_salt&.last(10)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[email]
  end
end
