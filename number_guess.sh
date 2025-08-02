#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

# Number Guessing Game

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