#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME

source /opt/ros/melodic/setup.bash

cd $AGRIBOT_HOME/agribot/workspace/base_ws
# rm -rf build/ bundle/ install/ log/
colcon build
source $AGRIBOT_HOME/agribot/workspace/base_ws/install/setup.bash

cd $AGRIBOT_HOME/agribot/workspace/hal_ws
# rm -rf build/ bundle/ install/ log/
colcon build
source $AGRIBOT_HOME/agribot/workspace/hal_ws/install/setup.bash

cd $AGRIBOT_HOME/agribot/workspace/simulation_ws
# rm -rf build/ bundle/ install/ log/
colcon build
source $AGRIBOT_HOME/agribot/workspace/simulation_ws/install/setup.bash
