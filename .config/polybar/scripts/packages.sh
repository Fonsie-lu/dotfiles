#!/bin/sh

packages=`checkupdates | wc -l` 

aur=`checkupdates-aur | wc -l` 

echo "  "$packages"|"$aur" " 

