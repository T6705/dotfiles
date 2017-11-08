#!/bin/bash

if ! pgrep -x spotify >/dev/null; then
    echo ""; exit
fi

status=`playerctl status`

if [ $status == Playing ]; then
    echo 
elif [ $status == Paused ]; then
    echo 
fi
