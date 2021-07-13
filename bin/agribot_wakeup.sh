#!/usr/bin/env bash

echo "wakeup" | nc -q 1 10.0.0.1 55785

while true; do
    if nc -W 1 10.0.0.1 55786 | grep -q "1"; then
        echo "Waking up"
    fi
    if nc -W 1 10.0.0.1 55786 | grep -q "2"; then
        echo "Running"
        break
    fi
done
