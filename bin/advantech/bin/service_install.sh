#!/usr/bin/env bash

sudo cp ../service/system/* /etc/systemd/system/
sudo cp ../service/user/* /etc/systemd/user/
systemctl --user daemon-reload
sudo systemctl daemon-reload
