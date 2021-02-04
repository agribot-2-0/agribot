#!/usr/bin/env bash

sudo apt update

cd $AGRIBOT_HOME/agribot/workspace/base_ws
rosdep install --from-paths src --ignore-src --rosdistro melodic -y

cd $AGRIBOT_HOME/agribot/workspace/hal_ws
rosdep install --from-paths src --ignore-src --rosdistro melodic -y

cd $AGRIBOT_HOME/agribot/workspace/simulation_ws
rosdep install --from-paths src --ignore-src --rosdistro melodic -y
