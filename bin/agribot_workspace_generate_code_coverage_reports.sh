#!/usr/bin/env bash

function test () {
    colcon test 
    lcov --capture --directory build/ --output-file $1_report.info -q --no-external -b src/
    lcov --remove $1_report.info -o $1_filtered.info -q '*/test/*' '*/test/**'
    genhtml $1_filtered.info --output-directory coverage_report -q
}

cd $AGRIBOT_HOME/agribot/workspace/base_ws

test base_ws

cd $AGRIBOT_HOME/agribot/workspace/hal_ws

test hal_ws

cd $AGRIBOT_HOME/agribot/workspace/simulation_ws

test simulation_ws