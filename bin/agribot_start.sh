#!/usr/bin/env bash

if [ "$1" == "simulation" ]
then
    source $AGRIBOT_HOME/agribot/configs/setup.bash simulation
    roslaunch agribot_bringup agribot_base_simulation.launch
else
    source $AGRIBOT_HOME/agribot/configs/setup.bash
    roslaunch agribot_bringup agribot_base.launch
fi
