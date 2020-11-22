#!/usr/bin/env sh
  
#kill all scripts (arch_updates)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar main &

# Launch arch_updates script
echo "Bars launched..."
