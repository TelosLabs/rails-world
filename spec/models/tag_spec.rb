# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
require "rails_helper"

RSpec.describe Tag, type: :model do
  let(:tag) { build_stubbed(:tag) }

  it "has a valid factory" do
    expect(tag).to be_valid
  end
end
