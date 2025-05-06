#!/bin/bash

# Enable exit on error, unset variables, and pipeline failures
set -euo pipefail

# Uncomment for debugging
set -x

# Default step value
STEP=5

function get_current_brightness() {
	# Use -t flag to specify display if multiple monitors
	ddcutil getvcp 10 | grep "Brightness" | grep -oE "current value = [a-zA-Z0-9. ]+," | grep -oE "[0-9]+"
}

function adjust_brightness() {
	# Check if ddcutil is installed
	if ! command -v ddcutil &>/dev/null; then
		echo "Error: ddcutil is not installed" >&2
		exit 1
	fi

	# Get current brightness
	current=$(get_current_brightness)
	if [[ -z "$current" ]]; then
		echo "Error: Failed to get current brightness" >&2
		exit 1
	fi

	case "$1" in
	"up")
		new=$((current + STEP))
		# Ensure we don't exceed maximum
		new=$((new > 100 ? 100 : new))
		ddcutil setvcp 10 "$new"
		notify-send -u normal "Brightness increased to: $new"
		;;
	"down")
		new=$((current - STEP))
		# Ensure we don't go below minimum
		new=$((new < 0 ? 0 : new))
		ddcutil setvcp 10 "$new"
		notify-send -u normal "Brightness decreased to: $new"
		;;
	"set")
		if [[ -z "$2" || ! "$2" =~ ^[0-9]+$ ]]; then
			echo "Error: Please provide a valid brightness value (0-100)" >&2
			exit 1
		fi

		new="$2"
		# Ensure value is within range
		if ((new < 0)); then new=0; fi
		if ((new > 100)); then new=100; fi

		ddcutil setvcp 10 "$new"
		notify-send -u normal "Brightness set to: $new"
		;;
	"get")
		echo "Current brightness: $current"
		;;
	*)
		echo "Usage: $0 [up|down|get|set VALUE]"
		echo "  up: Increase brightness by $STEP"
		echo "  down: Decrease brightness by $STEP"
		echo "  get: Display current brightness"
		echo "  set VALUE: Set brightness to VALUE (0-100)"
		exit 1
		;;
	esac
}

# Check if at least one argument is provided
if [[ $# -lt 1 ]]; then
	adjust_brightness "help"
	exit 1
fi

# Handle the "set" command which requires two arguments
if [[ "$1" == "set" && $# -eq 2 ]]; then
	adjust_brightness "$1" "$2"
else
	adjust_brightness "$1"
fi
