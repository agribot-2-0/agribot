#!/usr/bin/env bash

git clone https://github.com/panpawelchmiel/agribot_drivers.git drivers
git clone https://github.com/panpawelchmiel/agribot_configs.git configs
git clone https://github.com/panpawelchmiel/agribot_base.git workspace/base_ws/src
git clone https://github.com/panpawelchmiel/agribot_hal.git workspace/hal_ws/src

if [ "$1" == "simulation" ]
then
    git clone https://github.com/panpawelchmiel/agribot_simulation.git workspace/simulation_ws/src
fi