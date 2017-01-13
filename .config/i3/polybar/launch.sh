#!/usr/bin/env sh

# Terminate already running bar instances
killall polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bars
#polybar top_bar -c ~/.config/i3/polybar/config &
#polybar bottom_bar -c ~/.config/i3/polybar/config &
polybar example -c ~/.config/i3/polybar/config &
