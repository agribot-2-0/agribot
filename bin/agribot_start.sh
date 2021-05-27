#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME


if [ "$1" == "simulation" ]
then
    source $AGRIBOT_HOME/agribot/configs/setup.bash simulation
    roslaunch agribot_bringup agribot_base_simulation.launch
else
#    roslaunch hal_io_card hal_io_card.launch &
#    sleep 5
#    killall roslaunch
    source $AGRIBOT_HOME/agribot/configs/setup.bash
#    sleep 10
    roslaunch agribot_bringup agribot_base.launch
fi
