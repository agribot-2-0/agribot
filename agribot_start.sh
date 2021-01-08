#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME

source /opt/ros/melodic/setup.bash
source $AGRIBOT_HOME/agribot/workspace/base_ws/install/setup.bash
source $AGRIBOT_HOME/agribot/configs/simulation/config.bash

# roscore &

# sleep 30

if [ "$1" == "simulation" ]
then
    source $AGRIBOT_HOME/agribot/workspace/simulation_ws/install/setup.bash
    source $AGRIBOT_HOME/agribot/configs/base/bringup/config_simulation.bash
    roslaunch agribot_bringup agribot_base_simulation.launch
else
    source $AGRIBOT_HOME/agribot/workspace/hal_ws/install/setup.bash
    source $AGRIBOT_HOME/agribot/configs/base/bringup/config.bash
    roslaunch agribot_bringup agribot_base.launch
fi


