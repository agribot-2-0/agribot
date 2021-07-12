#!/usr/bin/env bash

sudo cp ../service/ /etc/systemd/system/
sudo systemctl daemon-reload
