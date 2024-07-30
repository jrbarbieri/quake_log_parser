# frozen_string_literal: true

module QuakeLogParser
  LINE_PATTERN = /Kill: \d+ \d+ \d+: (<world>|[\w\s]+) killed ([\w\s]+) by (MOD_[A-Z_]+)/.freeze

  LogEntry = Data.define(:killer, :victim, :mod) do
    def self.from_line(line)
      LINE_PATTERN.match(line) { new(*_1.captures) }
    end
  end
end
