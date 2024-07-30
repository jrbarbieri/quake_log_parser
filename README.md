## Introduction

This solution was created to parse log files from the game Quake.
The solution is implemented using the Ruby programming language and is structured as a Gem to build the script.

## How It Works

1. Clone this repository
2. Navigate to the directory using `cd quake_log_parser`
3. Run the command `bin/quake-log-parser <file_path> [--death-causes | --ranking | --summary]` to perform the desired operation. The available options are:
   a. `--summary`: returns a JSON with a summary presenting the total deaths of the match, the players involved, and the match score;
   b. `--ranking`: displays a ranking of kills per player across all matches in the log;  
   c. `--death-causes`: returns a JSON with the summary of the types of deaths of the players per match;
   d. **_no options_**: returns a JSON with the total deaths, all players, kill/player balance, means of death, and ranking for each match.

**Note**: The repository already contains an example log file named `log_example.txt`, so you can run the command `bin/quake-log-parser **log_example.txt** [--death-causes | --ranking | --summary]` if you want to test it.

## How It Works

When executing `bin/quake-log-parser`, the log file is sent to the `Parser` object, which in turn will create a collection of `Game` objects using the `LogEntry` object to read the relevant logs from the input file, then assigning the `Display` object the responsibility of presenting these data.

The `Game` object represents a match in the context of a Quake log parser. This object stores information about the match, including the name, total number of deaths, players involved, means of death, and a ranking. It facilitates the storage and manipulation of match data, allowing for the extraction of summaries and specific statistics.

The `LogEntry` object represents a log entry in the context of a Quake log parser. This object stores information about a death event (kill) in the game, including the killer, the victim, and the means of death. It facilitates the analysis and extraction of specific information about death events in Quake logs, allowing for the creation of organized data structures for further processing.

The `Parser` object is responsible for parsing Quake match log files, extracting and processing game events such as match starts and death events. This object facilitates the structured and detailed analysis of Quake game logs, enabling the extraction of statistics and the generation of rankings based on game events.

The `Display` object is responsible for displaying Quake game data in an organized and readable manner, using JSON formats and tables in the terminal. It facilitates the organized and detailed visualization of Quake match data, allowing for clear and structured analysis of game statistics.
