# frozen_string_literal: true

require_relative "lib/quake_log_parser/version"

Gem::Specification.new do |spec|
  spec.name = "quake_log_parser"
  spec.version = QuakeLogParser::VERSION
  spec.authors = ["Joao Barbieri"]
  spec.email = ["j.rafaeel@hotmail.com"]

  spec.summary = "A gem for parsing Quake log files and outputting game statistics in JSON format."
  spec.description = "The QuakeLogParser gem provides a command-line tool to parse Quake log files, extracting game statistics such as total kills and individual player kills, and outputting the results in JSON format. It is designed to help analyze game logs quickly and efficiently."
  spec.homepage = "https://github.com/jrbarbieri/quake_log_parser"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jrbarbieri/quake_log_parser"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
