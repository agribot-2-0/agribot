#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME


if [ "$1" == "simulation" ]
then
    source $AGRIBOT_HOME/agribot/configs/setup.bash simulation
    roslaunch agribot_bringup agribot_base_simulation.launch
elif [ "$1" == "jetson" ]
then
    source $AGRIBOT_HOME/agribot/configs/setup.bash jetson
    roslaunch agribot_obstacle_detection detection_demo.launch
elif [ "$1" == "advantech" ]
then
    source $AGRIBOT_HOME/agribot/configs/setup.bash advantech
    roslaunch agribot_bringup agribot_base.launch
elif [ "$1" == "advantech_io_card" ]
then
    source $AGRIBOT_HOME/agribot/configs/setup.bash advantech
    roslaunch hal_io_card hal_io_card.launch
else
    echo "Platform should be specify in first argument"
fi
