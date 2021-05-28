#!/usr/bin/env bash

cd $AGRIBOT_HOME/agribot/workspace/base_ws
if [ "$1" == "rebuild" ]
then
    rm -rf build/ bundle/ install/ log/
fi
colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
source $AGRIBOT_HOME/agribot/workspace/base_ws/install/setup.bash

cd $AGRIBOT_HOME/agribot/workspace/hal_ws
if [ "$1" == "rebuild" ]
then
    rm -rf build/ bundle/ install/ log/
fi
colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
source $AGRIBOT_HOME/agribot/workspace/hal_ws/install/setup.bash

cd $AGRIBOT_HOME/agribot/workspace/simulation_ws
if [ "$1" == "rebuild" ]
then
    rm -rf build/ bundle/ install/ log/
fi
colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
source $AGRIBOT_HOME/agribot/workspace/simulation_ws/install/setup.bash
