#!/usr/bin/env bash

source configs/setup.bash

source $AGRIBOT_HOME/agribot/configs/simulation/config.bash

# roscore &

# sleep 30

if [ "$1" == "simulation" ]
then
    source $AGRIBOT_HOME/agribot/configs/base/bringup/config_simulation.bash
    roslaunch agribot_bringup agribot_base_simulation.launch
else
    source $AGRIBOT_HOME/agribot/configs/base/bringup/config.bash
    roslaunch agribot_bringup agribot_base.launch
fi
