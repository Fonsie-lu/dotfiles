#!/bin/sh

cpu=`sensors | awk '/^CPU:/ {print $2}' | awk 'END {print}' | tr -d + | sed -e 's/\.0//' | tr -d C` 
rpm=`sensors | awk '/^fan1:/ {print $2}' | awk 'END {print}' | tr -d + | sed -e 's/\.0//' | tr -d C` 
light=`light`
s1=$(expr substr "${light}" 1 2)
echo " 糖$cpu   $rpm ﯧ $s1%  " 
