#!/bin/sh

mem=`free -m | awk '/^Mem:/ {print $3}'` 
echo "  "$mem" MB " 
