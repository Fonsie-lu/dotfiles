#!/bin/sh
while true; do
	temp=$(cat /sys/class/hwmon/hwmon4/temp1_input)
	temps=$(echo "${temp}" | sed 's/^\(..\).*/\1/')
	echo "cpu|string|"$temps""
	echo ""
	sleep 3
done
