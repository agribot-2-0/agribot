#!/bin/bash

cd $HOME
if [ ! -d "logs" ];then
    mkdir logs
fi
cd logs
export YEAR=$(date +%Y)
if [ ! -d "$YEAR" ]; then
    mkdir $YEAR
fi
cd $YEAR
export MONTH=$(date +%m)
if [ ! -d "$MONTH" ]; then
    mkdir $MONTH
fi
cd $MONTH
export DAY=$(date +%d)
if [ ! -d "$DAY" ]; then
    mkdir $DAY
fi
cd $DAY
export HOUR=$(date +%X)
mkdir $HOUR
cd $HOUR
    source $HOME/agribot/configs/setup.bash simulation

(rosbag record --quiet -a __name:=bag_record)&
(candump -L can0 > can0-$(date +%F)$(date +%X).log)&
(candump -L can1 > can1-$(date +%F)$(date +%X).log)&



