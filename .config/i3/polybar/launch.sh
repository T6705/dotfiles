#!/usr/bin/env sh

# Terminate already running bar instances
killall lemonbuddy

# Wait until the processes have been shut down
#while pgrep -x lemonbuddy >/dev/null; do sleep 1; done

# Launch bars
lemonbuddy top_bar -c ~/.config/i3/polybar/config &
lemonbuddy bottom_bar -c ~/.config/i3/polybar/config &
