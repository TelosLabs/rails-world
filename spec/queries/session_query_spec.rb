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
      let(:params) { {starts_at: Date.new(2024, 5, 19)} }

      it "returns sessions on that date" do
        _session_may_18 = create(:session, starts_at: Date.new(2024, 5, 18),
          location: past_session.location, conference: past_session.conference)
        session_may_19 = create(:session, starts_at: Date.new(2024, 5, 19),
          location: past_session.location, conference: past_session.conference)
        _session_may_20 = create(:session, starts_at: Date.new(2024, 5, 20),
          location: past_session.location, conference: past_session.conference)
        expect(session_query.call).to contain_exactly(session_may_19)
      end
    end

    context "when filtering by all statuses" do
      let(:params) { {live: "1", past: "1", starting_soon: "1"} }

      it "returns all sessions" do
        expect(session_query.call).to contain_exactly(past_session, live_session, starting_soon_session)
      end
    end

    # Filter by all combinations of statuses
    SessionQuery::STATUS_SCOPES.combination(2).each do |combo|
      context "when filtering by #{combo.join(" and ")} status" do
        let(:params) { combo.index_with { |filter| "1" }.to_h }

        it "returns #{combo.join(" and ")} sessions" do
          expected_sessions = combo.map { |filter| send(:"#{filter}_session") }
          expect(session_query.call).to match_array(expected_sessions)
        end
      end
    end

    # Filter by each status
    SessionQuery::STATUS_SCOPES.each do |filter|
      context "when filtering by #{filter} status" do
        let(:params) { {filter => "1"} }

        it "returns #{filter} sessions" do
          expect(session_query.call).to contain_exactly(send(:"#{filter}_session"))
        end
      end
    end
  end
end
