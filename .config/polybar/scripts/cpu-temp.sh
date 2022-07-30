#!/bin/sh

cpu=`sensors | awk '/^CPUTIN:/ {print $2}' | awk 'END {print}' | tr -d + | sed -e 's/\.0//' | tr -d C` 
echo " 糖"$cpu" " 
