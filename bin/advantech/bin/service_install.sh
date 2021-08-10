#!/usr/bin/env bash

sudo cp ../service/* /etc/systemd/system/
sudo cp ../service/user/* /etc/systemd/user/
systemctl --user deamon-reload
sudo systemctl daemon-reload
