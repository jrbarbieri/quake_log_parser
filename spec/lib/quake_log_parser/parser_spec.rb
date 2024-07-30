# frozen_string_literal: true

require "spec_helper"
require "quake_log_parser"

RSpec.describe QuakeLogParser::Parser do
  let(:log_file_path) { "spec/fixtures/test_log.txt" }
  let(:subject) { described_class.new(log_file_path).call }

  describe ".call" do
    it "parses the log file and generates the correct game data" do
      games = subject

      game1 = games.first
      game2 = games.last

      expect(game1).to have_attributes(
        name: "game_1",
        total_kills: 0,
        players: [],
        kills: {},
        means_of_death: {},
        ranking: {}
      )

      expect(game2).to have_attributes(
        name: "game_2",
        total_kills: 11,
        players: match_array(%w[Isgalamido Mocinha]),
        kills: { "Isgalamido" => -5 },
        means_of_death: { "MOD_FALLING" => 1, "MOD_ROCKET_SPLASH" => 3, "MOD_TRIGGER_HURT" => 7 },
        ranking: { "Isgalamido" => -5 }
      )
    end
  end
end
