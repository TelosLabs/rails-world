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

  has_one :profile, as: :profileable, dependent: :destroy

  has_and_belongs_to_many :events

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 8}, if: -> { password.present? }

  after_create_commit { create_profile! }

  enum role: {user: "user", admin: "admin"}

  accepts_nested_attributes_for :profile

  normalizes :email, with: ->(email) { email.strip.downcase }

  generates_token_for :password_reset, expires_in: PASSWORD_RESET_EXPIRATION do
    password_salt&.last(10)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[email]
  end
end
