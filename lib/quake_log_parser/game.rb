# frozen_string_literal: true

module QuakeLogParser
  class Game
    attr_accessor :name, :total_kills, :players, :kills, :means_of_death, :ranking

    def initialize(name)
      @name = name
      @total_kills = 0
      @players = []
      @kills = Hash.new(0)
      @means_of_death = Hash.new(0)
      @ranking = {}
    end

    def to_h
      {
        name => {
          total_kills: @total_kills,
          players: @players,
          kills: @kills,
          means_of_death: @means_of_death,
          ranking: @ranking
        }
      }
    end

    def summary
      {
        name => {
          total_kills: @total_kills,
          players: @players,
          kills: @kills
        }
      }
    end

    def death_causes
      {
        name => {
          kills_by_means: @means_of_death
        }
      }
    end
  end
end
