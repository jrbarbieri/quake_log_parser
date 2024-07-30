# frozen_string_literal: true

require "spec_helper"
require "quake_log_parser"

RSpec.describe QuakeLogParser::Display do
  let(:game1) do
    instance_double(
      QuakeLogParser::Game,
      name: "game_1",
      total_kills: 0,
      players: [],
      kills: {},
      means_of_death: {},
      ranking: {},
      to_h: { "game_1" => { total_kills: 0, players: [], kills: {}, means_of_death: {}, ranking: {} } },
      summary: { "game_1" => { total_kills: 0, players: [], kills: {} } },
      death_causes: { "game_1" => { kills_by_means: {} } }
    )
  end

  let(:game2) do
    instance_double(
      QuakeLogParser::Game,
      name: "game_2",
      total_kills: 2,
      players: ["Isgalamido"],
      kills: { "Isgalamido" => 2 },
      means_of_death: { "MOD_ROCKET_SPLASH" => 2 },
      ranking: { "Isgalamido" => 2 },
      to_h: {
        "game_2" => {
          total_kills: 2,
          players: ["Isgalamido"],
          kills: { "Isgalamido" => 2 },
          means_of_death: { "MOD_ROCKET_SPLASH" => 2 },
          ranking: { "Isgalamido" => 2 }
        }
      },
      summary: {
        "game_2" => {
          total_kills: 2,
          players: ["Isgalamido"],
          kills: { "Isgalamido" => 2 }
        }
      },
      death_causes: {
        "game_2" => {
          kills_by_means: { "MOD_ROCKET_SPLASH" => 2 }
        }
      }
    )
  end

  let(:games) { [game1, game2] }
  let(:display) { described_class.new(games) }

  describe "#display_data" do
    it "prints the data in JSON format" do
      expect do
        display.display_data
      end.to output("#{JSON.pretty_generate([game1.to_h, game2.to_h])}\n").to_stdout
    end
  end

  describe "#display_game_summary" do
    it "prints the game summary in JSON format" do
      expect do
        display.display_game_summary
      end.to output("#{JSON.pretty_generate([game1.summary, game2.summary])}\n").to_stdout
    end
  end

  describe "#display_death_causes" do
    it "prints the death causes in JSON format" do
      expect do
        display.display_death_causes
      end.to output("#{JSON.pretty_generate([game1.death_causes, game2.death_causes])}\n").to_stdout
    end
  end

  describe "#display_ranking" do
    let(:ranking_table_game1) do
      <<~TABLE
        +-----------+-----------+-----------+
        | Ranking   | Player    | Kills     |
        +-----------+-----------+-----------+
        | No data available for this match. |
        +-----------------------------------+
      TABLE
    end

    let(:ranking_table_game2) do
      <<~TABLE
        +---------+------------+-------+
        | Ranking | Player     | Kills |
        +---------+------------+-------+
        | #1      | Isgalamido | 2     |
        +---------+------------+-------+
        |        Total kills: 2        |
        +------------------------------+
      TABLE
    end

    it "prints the ranking tables for each game" do
      expected_output = "Game 1\n#{ranking_table_game1}\nGame 2\n#{ranking_table_game2}\n"

      expect { display.display_ranking }.to output(expected_output).to_stdout
    end
  end
end
