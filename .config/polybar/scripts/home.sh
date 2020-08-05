#!/bin/sh

mem=`df -m | awk '/sda3/ {print $5}'` 
echo "  "$mem" " 
