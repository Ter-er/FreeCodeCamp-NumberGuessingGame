#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

# Number Guessing Game

# Username prompt
echo Enter your username:
read USERNAME
USER_NAME=$($PSQL "SELECT username FROM number_guess WHERE username = '$USERNAME'")

# if user does not exist
if [[ -z $USER_NAME ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  echo "Guess the secret number between 1 and 1000:"
  # Game goes here
  # Insert username and game results after game
else
  echo "Welcome back, $USERNAME! You have played $PLAYED games, and your best game took $BEST guesses."
fi

RAND_NUM=$(( (RANDOM % 1000) + 1 ))

while [[ $GUESS -ne $RAND_NUM ]]
do
  read GUESS
  if [[ $GUESS -lt $RAND_NUM ]]
  then
    echo Higher
  elif [[ $GUESS -gt $RAND_NUM ]]
  then
    echo Lower
  elif [[ $GUESS -eq $RAND_NUM ]]
  then
    echo Correct
  fi
done