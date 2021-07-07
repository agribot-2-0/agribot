#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME

if [ "$1" == "build" ]
then
  docker-compose -f $AGRIBOT_HOME/agribot/workspace/base_ws/src/agribot_common/docker/docker-compose.yaml up --build
else
  docker-compose -f $AGRIBOT_HOME/agribot/workspace/base_ws/src/agribot_common/docker/docker-compose.yaml up
fi
