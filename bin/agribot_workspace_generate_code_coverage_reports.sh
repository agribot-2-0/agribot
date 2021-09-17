#!/usr/bin/env bash

cd $AGRIBOT_HOME/agribot/workspace/base_ws

colcon test 
lcov --capture --directory build/ --output-file base_ws_report.info -q --no-external -b src/
lcov --remove base_ws_report.info -o base_ws_filtered.info -q '*/include/*' '*/test/*' '*/include/**' '*/test/**'
genhtml base_ws_filtered.info --output-directory coverage_report -q

cd $AGRIBOT_HOME/agribot/workspace/hal_ws

colcon test 
lcov --capture --directory build/ --output-file hal_ws_report.info -q --no-external -b src/
lcov --remove hal_ws_report.info -o hal_ws_filtered.info -q '*/include/*' '*/test/*' '*/include/**' '*/test/**'
genhtml hal_ws_filtered.info --output-directory coverage_report -q

cd $AGRIBOT_HOME/agribot/workspace/simulation_ws

colcon test 
lcov --capture --directory build/ --output-file simulation_ws_report.info -q --no-external -b src/
lcov --remove simulation_ws_report.info -o simulation_ws_filtered.info -q '*/include/*' '*/test/*' '*/include/**' '*/test/**'
genhtml simulation_ws_filtered.info --output-directory coverage_report -q