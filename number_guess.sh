#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

# Number Guessing Game

# Username prompt
echo "Enter your username:"
read USERNAME
USER_NAME=$($PSQL "SELECT username, games_played, best_game FROM number_guess WHERE username = '$USERNAME'")

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
  # Insert username and game results after game
  GAME_INFO=$($PSQL "INSERT INTO number_guess(username, games_played, best_game) VALUES('$USERNAME', 1, $TRIES)")

else
  IFS='|' read DB_USERNAME PLAYED BEST <<< "$USER_NAME"
  DB_USERNAME=$(echo "$DB_USERNAME" | xargs)
  PLAYED=$(echo "$PLAYED" | xargs)
  BEST=$(echo "$BEST" | xargs)
  echo "Welcome back, $DB_USERNAME! You have played $PLAYED games, and your best game took $BEST guesses."
  echo "Guess the secret number between 1 and 1000:"

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

  PLAYED=$((PLAYED + 1))
  if [[ $TRIES -lt $BEST || $BEST -eq 0 ]]
  then
    NEW_GAME_INFO=$($PSQL "UPDATE number_guess SET games_played=$PLAYED, best_game=$TRIES WHERE username='$USERNAME'")
  else
    NEW_GAME_INFO=$($PSQL "UPDATE number_guess SET games_played=$PLAYED WHERE username='$USERNAME'")
  fi
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