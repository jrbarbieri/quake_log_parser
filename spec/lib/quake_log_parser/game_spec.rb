# frozen_string_literal: true

require "spec_helper"
require "quake_log_parser/game"

RSpec.describe QuakeLogParser::Game do
  let(:game) { described_class.new("TestGame") }

  describe "#initialize" do
    it "initializes with the correct attributes" do
      expect(game).to have_attributes(
        name: "TestGame",
        total_kills: 0,
        players: [],
        kills: {},
        means_of_death: {},
        ranking: {}
      )
    end
  end

  describe "#summary" do
    it "returns a summary hash of the game" do
      expected_summary = {
        "TestGame" => {
          total_kills: 0,
          players: [],
          kills: {}
        }
      }

      expect(game.summary).to eq(expected_summary)
    end
  end

  describe "#death_causes" do
    it "returns a hash of kills by means of death" do
      expected_death_causes = {
        "TestGame" => {
          kills_by_means: {}
        }
      }

      expect(game.death_causes).to eq(expected_death_causes)
    end
  end

  describe "#generate_ranking" do
    let(:players_kills) { { "Player1": 2, "Player2": 3, "Player3": 1 } }
    let(:expected_ranking) { { "Player2": 3, "Player1": 2, "Player3": 1 } }

    before { players_kills.each { game.kills[_1] = _2 } }

    it "generates a ranking hash sorted by kills" do
      game.generate_ranking

      expect(game.ranking).to eq(expected_ranking)
    end
  end
end
