# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string           not null
#  in_app_notifications_enabled :boolean          default(TRUE), not null
#  mail_notifications_enabled   :boolean          default(TRUE), not null
#  role                         :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  normalizes :email, with: ->(email) { email.strip.downcase }

  has_one :profile, as: :profileable, dependent: :destroy

  has_and_belongs_to_many :events

  validates :email, presence: true, uniqueness: true
end
