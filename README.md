# Quake Log Parser

## Introduction

This solution was created to parse log files from the game Quake. The solution is implemented using the Ruby programming language and is structured as a Gem to build the script.

## Installation

1. Clone this repository:
   ```sh
   git clone <repository_url>
   ```
2. Navigate to the directory:
   ```sh
   cd quake_log_parser
   ```
3. Install the dependencies:
   ```sh
   bundle install
   ```

## How to Use

Run the command `bin/quake-log-parser <file_path> [--death-causes | --ranking | --summary]` to perform the desired operation. The available options are:

- `--summary`: returns a JSON with a summary presenting the total deaths of the match, the players involved, and the match score.
- `--ranking`: displays a ranking of kills per player across all matches in the log.
- `--death-causes`: returns a JSON with the summary of the types of deaths of the players per match.
- **_no options_**: returns a JSON with the total deaths, all players, kill/player balance, means of death, and ranking for each match.

**Note**: The repository already contains an example log file named `log_example.txt`, so you can run the command `bin/quake-log-parser log_example.txt [--death-causes | --ranking | --summary]` to test it.

## How It Works

When executing `bin/quake-log-parser`, the log file is sent to the `Parser` object, which creates a collection of `Game` objects using the `LogEntry` object to read the relevant logs from the input file. The `Display` object is then responsible for presenting these data.

### Components

- **`Game`**: Represents a match in the context of a Quake log parser. This object stores information about the match, including the name, total number of deaths, players involved, means of death, and a ranking. It facilitates the storage and manipulation of match data, allowing for the extraction of summaries and specific statistics.
- **`LogEntry`**: Represents a log entry in the context of a Quake log parser. This object stores information about a death event (kill) in the game, including the killer, the victim, and the means of death. It facilitates the analysis and extraction of specific information about death events in Quake logs, allowing for the creation of organized data structures for further processing.

- **`Parser`**: Responsible for parsing Quake match log files, extracting and processing game events such as match starts and death events. This object facilitates the structured and detailed analysis of Quake game logs, enabling the extraction of statistics and the generation of rankings based on game events.

- **`Display`**: Responsible for displaying Quake game data in an organized and readable manner, using JSON formats and tables in the terminal. It facilitates the organized and detailed visualization of Quake match data, allowing for clear and structured analysis of game statistics.

## Running Tests

The project includes tests to ensure the correctness of the parsing and data representation logic. To run the tests:

1. Ensure you have installed the dependencies:
   ```sh
   bundle install
   ```
2. Run the tests using RSpec:
   ```sh
   rspec
   ```
