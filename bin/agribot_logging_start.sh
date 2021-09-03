#!/bin/bash

export AGRIBOT_HOME=$HOME
source $AGRIBOT_HOME/agribot/configs/setup.bash advantech

export YEAR=$(date +%Y)
export MONTH=$(date +%m)
export DAY=$(date +%d)
export HOUR=$(date +%X)
export DATE=$(date +%F)

mkdir -p "$AGRIBOT_HOME/logs/$YEAR/$MONTH/$DAY/$HOUR/"
if [ "$1" ]; then
    source $AGRIBOT_HOME/agribot/configs/base/logs/$1
else
    source $AGRIBOT_HOME/agribot/configs/base/logs/default_topic_list.txt
fi

(rosbag record --quiet -O $AGRIBOT_HOME/logs/$YEAR/$MONTH/$DAY/$HOUR/rosbag-$DATE-$HOUR.bag $TOPIC_LIST __name:=bag_record)&
(candump -L can0 > $AGRIBOT_HOME/logs/$YEAR/$MONTH/$DAY/$HOUR/can0-$DATE-$HOUR.log)&
(candump -L can1 > $AGRIBOT_HOME/logs/$YEAR/$MONTH/$DAY/$HOUR/can1-$DATE-$HOUR.log)&
