# Number Guessing Game

## Project Overview

This project is a command-line number guessing game implemented with Bash scripting and backed by a PostgreSQL database. Users are prompted to guess a secret random number between 1 and 1000, and the game tracks user statistics including the total number of games played and the best (lowest) number of guesses for each player.

## Features

- **Random number generation:** Each game starts by generating a random secret number between 1 and 1000.
- **User identification:** Players enter a username (up to 22 characters) to track their game history.
- **Database integration:** The game stores user statistics (games played and best game) in a PostgreSQL database named `number_guess`.
- **Persistent user stats:** Returning users are greeted with their past performance stats.
- **Input validation:** The script ensures user guesses are valid integers and provides feedback if they are not.
- **Guidance messages:** Players receive hints whether their guess is too high or too low until they guess correctly.
- **Detailed game summary:** Upon guessing correctly, the game reports the number of tries taken.

## Technical Details

- The project uses a PostgreSQL database called `number_guess` with a single table storing:
  - `username` (VARCHAR(22), PRIMARY KEY)
  - `games_played` (INTEGER)
  - `best_game` (INTEGER)

- The Bash script (`number_guess.sh`) interacts with the database using the `psql` command-line tool via a configured `PSQL` variable.

- The script includes logic for:
  - Checking if a username exists.
  - Inserting new users with initial stats.
  - Updating existing users' stats based on the outcome of the current game.

- The script provides user-friendly prompts and error handling for incorrect inputs.
