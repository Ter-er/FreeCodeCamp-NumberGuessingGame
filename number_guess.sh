#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

# Number Guessing Game

# Username prompt
echo "Enter your username:"
read USERNAME
USER_NAME=$($PSQL "SELECT username FROM number_guess WHERE username = '$USERNAME'")

# if user does not exist
if [[ -z $USER_NAME ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  echo "Guess the secret number between 1 and 1000:"

  # Game goes here
  RAND_NUM=$(( (RANDOM % 1000) + 1 ))
  TRIES=0
  GUESS=0

  while [[ $GUESS -ne $RAND_NUM ]]
  do
    read GUESS
    ((TRIES++))
    if ! [[ "$GUESS" =~ ^[0-9]+$ ]]
    then
      echo "That is not an integer, guess again:"
    elif [[ $GUESS -lt $RAND_NUM ]]
    then
      echo "It's higher than that, guess again:"
    elif [[ $GUESS -gt $RAND_NUM ]]
    then
      echo "It's lower than that, guess again:"
    else
      echo "You guessed it in $TRIES tries. The secret number was $RAND_NUM. Nice job!"
    fi
  done

  GAME_INFO=$($PSQL "INSERT INTO number_guess(username, games_played, best_game) VALUES('$USERNAME', 1, $TRIES)")

  # Insert username and game results after game
elif [[ "$USERNAME" == "$USER_NAME" ]]
then
  echo "Welcome back, $USERNAME! You have played $PLAYED games, and your best game took $BEST guesses."
  echo "Guess the secret number between 1 and 1000:"
fi





# RAND_NUM=$(( (RANDOM % 1000) + 1 ))

# while [[ $GUESS -ne $RAND_NUM ]]
# do
#   read GUESS
#   if [[ $GUESS -lt $RAND_NUM ]]
#   then
#     echo Higher
#   elif [[ $GUESS -gt $RAND_NUM ]]
#   then
#     echo Lower
#   elif [[ $GUESS -eq $RAND_NUM ]]
#   then
#     echo Correct
#   fi
# done