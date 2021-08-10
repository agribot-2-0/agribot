#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME
source $AGRIBOT_HOME/agribot/configs/setup.bash advantech
rosnode kill /bag_record
killall candump
