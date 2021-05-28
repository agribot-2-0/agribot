#!/usr/bin/env bash

echo "Switching power on"
rosservice call /io_card/out "pin: 2
state: 1"
