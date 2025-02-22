# frozen_string_literal: true

require "terminal-table"
require "json"

module QuakeLogParser
  class Display
    def initialize(games)
      @games = games
    end

    def display_data
      pretty_print_json(@games.map(&:to_h))
    end

    def display_game_summary
      pretty_print_json(@games.map(&:summary))
    end

    def display_death_causes
      pretty_print_json(@games.map(&:death_causes))
    end

    def display_ranking
      @games.each { puts _1.name.gsub("_", " ").capitalize, create_ranking_table(_1), "\n" }
    end

    private

    def pretty_print_json(data)
      puts JSON.pretty_generate(data)
    end

    def create_ranking_table(game)
      Terminal::Table.new do |t|
        t << %w[Ranking Player Kills]
        t << :separator
        if game.total_kills.zero? && game.players.empty?
          t.add_row [{ value: "No data available for this match.", colspan: 3, alignment: :center }]
        else
          add_ranking_rows(t, game.ranking)
          t << :separator
          t.add_row [{ value: "Total kills: #{game.total_kills}", colspan: 3, alignment: :center }]
        end
      end
    end

    def add_ranking_rows(table, ranking)
      ranking.each_with_index { |(player, kills), index| table << ["##{index + 1}", player, kills] }
    end
  end
end
