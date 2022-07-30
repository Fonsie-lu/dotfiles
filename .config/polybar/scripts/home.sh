#!/bin/sh

mem=`df -m | awk 'NR==4 {print $5}'` 
echo "  "$mem" " 
