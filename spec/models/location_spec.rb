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
require "rails_helper"

RSpec.describe Location, type: :model do
  let(:location) { build(:location) }

  it "has a valid factory" do
    expect(location).to be_valid
  end
end
