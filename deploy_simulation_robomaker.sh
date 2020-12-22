#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME

source /opt/ros/melodic/setup.bash

cd $AGRIBOT_HOME/agribot/workspace/base_ws
# rm -rf build/ bundle/ install/ log/
colcon build
mkdir ./install/agribot/configs -p
cp -r $AGRIBOT_HOME/agribot/configs ./install/agribot
colcon bundle

cd $AGRIBOT_HOME/agribot/workspace/simulation_ws
# rm -rf build/ bundle/ install/ log/
colcon build
mkdir ./install/agribot/configs -p
cp -r $AGRIBOT_HOME/agribot/configs ./install/agribot
colcon bundle

cd $AGRIBOT_HOME/agribot/workspace
docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli s3 cp /aws/base_ws/bundle/output.tar s3://agribot/agribot/base_ws/bundle/output.tar
docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli s3 cp /aws/simulation_ws/bundle/output.tar s3://agribot/agribot/simulation_ws/bundle/output.tar

docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli robomaker create-simulation-job \
--output-location s3Bucket=agribot-simulation-output \
--max-job-duration-in-seconds 1200 \
--iam-role arn:aws:iam::108011531825:role/service-role/agribot-iam \
--failure-behavior Fail \
--robot-applications application='arn:aws:robomaker:us-east-2:108011531825:robot-application/agribot-base/1590405174844,launchConfig={packageName="agribot_bringup",launchFile="agribot_base_robomaker.launch",streamUI="true",environmentVariables={AGRIBOT_HOME="/home/robomaker/workspace/applications/robot-application/workspace/opt/built_workspace",AGRIBOT_LAUNCH_TYPE="robomaker",AGRIBOT_MAPVIZ="false",AGRIBOT_MONITORING="false",AGRIBOT_PATH_SYNCHRONIZATION="false",AGRIBOT_PERCEPTION_SENSORS="false",AGRIBOT_PERCEPTION_SENSORS="false",AGRIBOT_SIMULATION_PERCEPTION_PLUGINS="false",AGRIBOT_SIMULATION_TASK="test_task",AGRIBOT_SMACH_VIEWER="false",AGRIBOT_TASK_SUPERVISOR="false",AGRIBOT_VIS="false"}}' \
--simulation-applications application='arn:aws:robomaker:us-east-2:108011531825:simulation-application/vineyard-simulation/1590346270677,launchConfig={packageName="agribot_simulation",launchFile="agribot_simulation_robomaker.launch",streamUI="true",environmentVariables={AGRIBOT_HOME="/home/robomaker/workspace/applications/simulation-application/workspace/opt/built_workspace",AGRIBOT_SIMULATION_ALTITUDE="193.7327916698572",AGRIBOT_SIMULATION_GAZEBO_DEBUG="false",AGRIBOT_SIMULATION_GAZEBO_GUI="false",AGRIBOT_SIMULATION_HEADING="158.5507847682035",AGRIBOT_SIMULATION_LATITUDE="51.26662409135839",AGRIBOT_SIMULATION_LONGITUDE="17.20327894189977",AGRIBOT_SIMULATION_MOBILE_APP="false",AGRIBOT_PERCEPTION_SENSORS="false",AGRIBOT_SIMULATION_PERCEPTION_PLUGINS="false",AGRIBOT_SIMULATION_ROBOT_START_YAW="0",AGRIBOT_SIMULATION_TASK="test_task",AGRIBOT_SIMULATION_WORLD="vineyard"}}'
