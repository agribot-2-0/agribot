#!/bin/bash

cd $HOME
if [ ! -d "logs" ];then
    mkdir logs
fi
cd logs
if [ ! -d "$(date +%Y)" ]; then
    mkdir $(date +%Y)
fi
cd $(date +%Y)
if [ ! -d "$(date +%m)" ]; then
    mkdir $(date +%m)
fi
cd $(date +%m)
if [ ! -d "$(date +%d)" ]; then
    mkdir $(date +%d)
fi
cd $(date +%d)
if [ $# -eq 1 ]; then
mkdir $1-$(date +%X)
cd $1-$(date +%X)
else
mkdir $(date +%X)
cd $(date +%X)
fi

(rosbag record --quiet -a __name:=bag_record)  &
(candump -L can0 > can0-$(date +%F)$(date +%X).log) &
(candump -L can1 > can1-$(date +%F)$(date +%X).log) &
