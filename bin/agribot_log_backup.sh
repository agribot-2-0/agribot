#!/usr/bin/env bash
export $AGRIBOT_HOME=$HOME

source $AGRIBOT_HOME/agribot/configs/setup.bash simulation
if [ "$ROS_DISTRO" == "noetic" ]
then
    python3 /home/agribot1/agribot/workspace/base_ws/install/agribot_common/lib/python3/dist-packages/agribot_common/logs_backup/upload_to_drive.py -p /home/agribot1/logs -k /home/agribot1/agribot/configs/base/drive_api_key -yaml "/home/agribot1/agribot/configs/base/robot.yaml"
elif ["$ROS_DISTRO" == "melodic" ]
then 
    python3 /home/agribot1/agribot/workspace/base_ws/install/agribot_common/lib/python2.7/dist-packages/agribot_common/logs_backup/upload_to_drive.py -p /home/agribot1/logs -k /home/agribot1/agribot/configs/base/drive_api_key -yaml "/home/agribot1/agribot/configs/base/robot.yaml"