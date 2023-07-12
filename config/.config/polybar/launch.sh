#!/bin/bash
# terminate alrady running bar instances
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done
polybar -rq main &
echo "Polybar launched."
