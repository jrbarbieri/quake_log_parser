# frozen_string_literal: true

require "spec_helper"
require "quake_log_parser"

RSpec.describe QuakeLogParser::LogEntry do
  describe ".from_line" do
    context "when the line matches the pattern" do
      let(:line) { "Kill: 1022 2 22: Joao killed Rafael by MOD_ROCKET" }
      let(:log_entry) { described_class.from_line(line) }

      it "extract the killer correctly" do
        expect(log_entry.killer).to eq("Joao")
      end

      it "extract the victim correctly" do
        expect(log_entry.victim).to eq("Rafael")
      end

      it "extract the mod correctly" do
        expect(log_entry.mod).to eq("MOD_ROCKET")
      end
    end

    context "when the line does not match the pattern" do
      let(:line) { "Invalid log line" }

      it "returns nil" do
        expect(described_class.from_line(line)).to be_nil
      end
    end
  end
end
