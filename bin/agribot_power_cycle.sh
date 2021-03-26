#!/usr/bin/env bash

echo "Switching power off"
rosservice call /io_card/out "pin: 2
state: 0"

echo "Switching power on"
rosservice call /io_card/out "pin: 2
state: 1"
