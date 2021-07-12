#!/usr/bin/env bash

sudo ip link set can0 up type can bitrate 250000 restart-ms 100
sudo ip link set can1 up type can bitrate 250000 restart-ms 100
