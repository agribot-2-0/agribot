#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME
source $AGRIBOT_HOME/agribot/configs/setup.bash advantech

export YEAR=$(date +%Y)
export MONTH=$(date +%m)
export DAY=$(date +%d)
export HOUR=$(date +%X)
export DATE=$(date +%F)

mkdir -p "$AGRIBOT_HOME/logs/$YEAR/$MONTH/$DAY/$HOUR/"

(rosbag record --quiet -a  -O $AGRIBOT_HOME/logs/$YEAR/$MONTH/$DAY/$HOUR/rosbag-$DATE-$HOUR.bag __name:=bag_record)&
(candump -L can0 > $AGRIBOT_HOME/logs/$YEAR/$MONTH/$DAY/$HOUR/can0-$DATE-$HOUR.log)&
(candump -L can1 > $AGRIBOT_HOME/logs/$YEAR/$MONTH/$DAY/$HOUR/can1-$DATE-$HOUR.log)&



