# == Schema Information
#
# Table name: conferences
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Conference, type: :model do
  let(:conference) { build_stubbed(:conference) }

  it "has a valid factory" do
    expect(conference).to be_valid
  end
end
