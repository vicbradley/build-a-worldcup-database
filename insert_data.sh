#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams,games");

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  
  if [[ $YEAR != year ]]
  then
    #INSERT teams from games.csv into teams database
    # check the winner team in games.csv
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # if not found
    if [[ -z $WINNER_ID ]]
    then
      # insert team
      # INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")
      echo $($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")

      # if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      # then
      #   echo "Inserted into teams, $WINNER"
      # fi

      # get winner_id
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # check the opponent team in games.csv
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # if not found
    if [[ -z $OPPONENT_ID ]]
    then
      # insert team
      # INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")
      echo $($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")

      # echo $INSERT_TEAM_RESULT
      # if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      # then
      #   echo "Inserted into teams, $OPPONENT"
      # fi

      # get opponent_id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

    # insert games
    # INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")
    # echo $INSERT_GAME_RESULT
    echo $($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")

    # if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    # then
    #   echo "Inserted into games"
    # fi
  fi

done
