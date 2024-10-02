# == Schema Information
#
# Table name: speakers
#
#  id         :integer          not null, primary key
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_speakers_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :speaker do
    profile { create(:profile, :with_user) }
  end
end
