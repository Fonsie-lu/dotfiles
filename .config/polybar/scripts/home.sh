#!/bin/sh

mem=`df -m | awk '/sda2/ {print $5}'` 
echo "  "$mem" " 
