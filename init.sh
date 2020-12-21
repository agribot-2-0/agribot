#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME

cd $AGRIBOT_HOME/agribot/workspace/base_ws/src
git submodule update --init

cd $AGRIBOT_HOME/agribot/workspace/hal_ws/src
git submodule update --init
