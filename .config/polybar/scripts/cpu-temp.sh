#!/bin/sh

cpu=`sensors | awk '/^temp1:/ {print $2}' | awk 'END {print}' | tr -d + | sed -e 's/.0//' | tr -d C` 
echo $cpu" " 
