#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME
source $AGRIBOT_HOME/agribot/configs/setup.bash advantech

cd $AGRIBOT_HOME

export YEAR=$(date +%Y)
export MONTH=$(date +%m)
export DAY=$(date +%d)
export HOUR=$(date +%X)


mkdir -p "logs/$YEAR/$MONTH/$DAY/$HOUR/"
cd logs/$YEAR/$MONTH/$DAY/$HOUR/

(rosbag record --quiet -a __name:=bag_record)&
(candump -L can0 > can0-$(date +%F)$(date +%X).log)&
(candump -L can1 > can1-$(date +%F)$(date +%X).log)&



