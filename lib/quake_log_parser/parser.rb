# frozen_string_literal: true

module QuakeLogParser
  class Parser
    def self.call(file_path)
      new(file_path).call
    end

    def initialize(file_path)
      @file_path = file_path
    end

    def call
      parse_file
    end

    private

    def parse_file
      @games = []
      @game_counter = 0

      File.readlines(@file_path).each do |line|
        next unless valid_line?(line)

        new_game?(line)

        if kill_event?(line)
          current_game = @games.last
          log_entry = LogEntry.from_line(line)
          process_kill(log_entry, current_game) if log_entry
        end
      end

      @games.each { |game| game.ranking = generate_ranking(game.kills) }
    end

    def valid_line?(line)
      line.include?("InitGame") || line.include?("Kill")
    end

    def new_game?(line)
      return unless line.include?(" InitGame:")

      @game_counter += 1
      @games << Game.new("game_#{@game_counter}")
    end

    def kill_event?(line)
      line.include?(" Kill: ")
    end

    def process_kill(log_entry, game)
      game.total_kills += 1
      add_players(log_entry, game)
      update_kills(log_entry, game)
      update_means_of_death(log_entry, game)
    end

    def add_players(log_entry, game)
      game.players << log_entry.victim unless game.players.include?(log_entry.victim)
      game.players << log_entry.killer unless log_entry.killer == "<world>" || game.players.include?(log_entry.killer)
    end

    def update_kills(log_entry, game)
      return game.kills[log_entry.killer] += 1 if log_entry.killer != "<world>"

      game.kills[log_entry.victim] -= 1
    end

    def update_means_of_death(log_entry, game)
      game.means_of_death[log_entry.mod] += 1
    end

    def generate_ranking(kills)
      kills.sort_by { |_, v| -v }.to_h
    end
  end
end
