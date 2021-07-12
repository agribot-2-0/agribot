#!/usr/bin/env bash

# TODO run pylint from docker
pylint --rcfile=$AGRIBOT_HOME/agribot/workspace/base_ws/src/agribot_common/pylint_conf/.pylintrc scripts/*
