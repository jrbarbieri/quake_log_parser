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
