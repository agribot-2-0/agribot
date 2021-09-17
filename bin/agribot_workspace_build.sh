#!/usr/bin/env bash
rebuild='false'
coverage='false'

while getopts 'rch' flag; do 
    case "${flag}" in
        r ) rebuild='true' ;;
        c ) coverage='true' ;;
        h ) echo "Usage:"
            echo "[-h] prints usage"
            echo "[-c] build with coverage reports"
            echo "[-r] rebuild."
            exit 1 ;;
        \? ) break ;;
    esac 
done

cd $AGRIBOT_HOME/agribot/workspace/base_ws
if [ "$rebuild" == 'true' ]
then
    rm -rf build/ bundle/ install/ log/
fi
if [ "$coverage" == 'true' ]
then
    colcon build --cmake-args -DCMAKE_CXX_FLAGS="--coverage" -DCMAKE_CXX_OUTPUT_EXTENSION_REPLACE=ON
else
    colcon build
fi
source $AGRIBOT_HOME/agribot/workspace/base_ws/install/setup.bash

cd $AGRIBOT_HOME/agribot/workspace/hal_ws
if [ "$rebuild" == 'true' ]
then
    rm -rf build/ bundle/ install/ log/
fi
if [ "$coverage" == 'true' ]
then
    colcon build --cmake-args -DCMAKE_CXX_FLAGS="--coverage" -DCMAKE_CXX_OUTPUT_EXTENSION_REPLACE=ON
else
    colcon build
fi
source $AGRIBOT_HOME/agribot/workspace/hal_ws/install/setup.bash

cd $AGRIBOT_HOME/agribot/workspace/simulation_ws
if [ "$rebuild" == 'true' ]
then
    rm -rf build/ bundle/ install/ log/
fi
if [ "$coverage" == 'true' ]
then
    colcon build --cmake-args -DCMAKE_CXX_FLAGS="--coverage" -DCMAKE_CXX_OUTPUT_EXTENSION_REPLACE=ON
else
    colcon build
fi
source $AGRIBOT_HOME/agribot/workspace/simulation_ws/install/setup.bash
