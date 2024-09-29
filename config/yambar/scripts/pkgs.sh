#!/bin/sh
while true; do
	home=$(df -h | awk '/n1p2/{printf $5}')
	echo "home|string|"$home
	echo ""
	sleep 60
done
