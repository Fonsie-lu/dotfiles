#!/bin/sh

mem=`amixer | awk '/^  Front Left: Playback/ {print $5}' | tr -d [ | tr -d ]` 
echo "  "$mem" " 
