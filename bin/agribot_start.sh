#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME


if [ "$1" == "simulation" ]
then
    source $AGRIBOT_HOME/agribot/configs/setup.bash simulation
    roslaunch agribot_bringup agribot_base_simulation.launch
else
    source $AGRIBOT_HOME/agribot/configs/setup.bash
    sh /home/agribot1/agribot/bin/agribot_docker_start.sh &
    sh /home/agribot1/agribot/bin/advantech_local_sleep.sh 10.0.1.2 &
    roslaunch hal_io_card hal_io_card.launch &
    sleep 5
    killall roslaunch
    sleep 10
    echo "agri1234" | sudo -S  ifconfig enp0s31f6 192.168.0.66 up
    roslaunch agribot_bringup agribot_base.launch
fi
