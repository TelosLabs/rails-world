# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionQuery, type: :query do
  let(:session_query) { described_class.new(params: params) }
  let!(:past_session) { create(:session, :past) }
  let!(:live_session) { create(:session, :live, location: past_session.location, conference: past_session.conference) }
  let!(:starting_soon_session) { create(:session, :starting_soon, location: past_session.location, conference: past_session.conference) }
  let(:params) { {} }

  describe "#call" do
    context "when no params are passed" do
      it "returns all sessions" do
        expect(session_query.call).to contain_exactly(past_session, live_session, starting_soon_session)
      end
    end

    context "when filtering by date" do
      let(:params) { {on_date: past_session.starts_at.to_date} }

      it "returns sessions on that date" do
        expect(session_query.call).to contain_exactly(past_session)
      end
    end

    context "when filtering by multiple status" do
      let(:params) { {live: "1", past: "1"} }

      it "returns live sessions" do
        expect(session_query.call).to contain_exactly(live_session, past_session)
      end
    end
  end
end
