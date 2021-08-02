#!/usr/bin/env bash

sudo cp ../service/* /etc/systemd/system/
loginctl enable-linger agribot1
sudo systemctl daemon-reload
