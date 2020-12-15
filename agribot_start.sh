#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME

source /opt/ros/melodic/setup.bash
source $HOME/agribot/workspace/base_ws/install/setup.bash
source $HOME/agribot/configs/simulation/config.bash

# export ROS_MASTER_URI=http://192.168.0.110:11311
# export ROS_MASTER_URI=http://127.0.0.1:11311
# export ROS_IP=192.168.0.112

# roscore &

# sleep 30

if [ "$1" == "simulation" ]
then
    source $HOME/agribot/workspace/simulation_ws/install/setup.bash
    source $HOME/agribot/configs/base/bringup/config_simulation.bash
    roslaunch --wait agribot_bringup agribot_base_simulation.launch
else
    source $HOME/agribot/workspace/hal_ws/install/setup.bash
    source $HOME/agribot/configs/base/bringup/config.bash
    roslaunch --wait agribot_bringup agribot_base.launch
fi


