#!/bin/bash

scrot /tmp/screen.png

if [ -f ~/git/hub/corrupter/corrupter ]; then
    ~/git/hub/corrupter/corrupter /tmp/screen.png /tmp/screen.png
else
    convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
fi

#[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
[[ -f ~/.config/i3/lock.png ]] && convert /tmp/screen.png ~/.config/i3/lock.png -gravity center -composite -matte /tmp/screen.png

#dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
status=$(playerctl status)
if [ "$status" == "Playing" ]; then
    playerctl pause
fi

i3lock -i /tmp/screen.png
rm /tmp/screen.png
