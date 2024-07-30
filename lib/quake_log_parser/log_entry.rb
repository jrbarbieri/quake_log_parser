# frozen_string_literal: true

module QuakeLogParser
  LogEntry = Struct.new(:killer, :victim, :mod) do
    def self.from_line(line)
      return unless line =~ /Kill: \d+ \d+ \d+: (<world>|[\w\s]+) killed ([\w\s]+) by (MOD_[A-Z_]+)/

      killer = ::Regexp.last_match(1)
      victim = ::Regexp.last_match(2)
      mod = ::Regexp.last_match(3)
      new(killer, victim, mod)
    end
  end
end
