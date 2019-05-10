#!/bin/bash

if command -v bluetoothctl &> /dev/null ; then
    connectedDevice=$(bluetoothctl info | grep Name | awk '{print $2}')
    if [[ -n "$connectedDevice" ]]; then
        echo "  $connectedDevice"
    else
        echo "  not connected device"
    fi
else
    echo ""
fi
