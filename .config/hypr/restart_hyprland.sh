#!/bin/bash

if ! pgrep -x "Hyprland" >/dev/null; then
	# Restart Hyprland if it's not running
	hyprctl dispatch exit && sleep 2 && Hyprland
fi
