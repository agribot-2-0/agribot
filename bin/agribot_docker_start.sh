#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME

docker-compose -f $AGRIBOT_HOME/agribot/workspace/base_ws/src/agribot_common/docker/docker-compose.yaml up
