#!/usr/bin/env bash

echo "wakeup" | nc -q 1 10.0.0.1 55785
