#!/bin/sh

while true; do
    if nc -l -s $1 -p 55786 | grep -q "sleep"; then
        echo "Sleep advantech"
        pkill launch
	sleep 5
	echo "agri1234" | sudo -S shutdown -h 0
    fi
done
