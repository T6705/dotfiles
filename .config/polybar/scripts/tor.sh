#!/bin/bash

if command -v tor &> /dev/null ; then
    status=$(systemctl status tor | grep Active | cut -d":" -f2 | cut -d" " -f2)
    if [[ -n "$status" ]] && [[ "$status" == "active" ]];then
            echo "  tor"
    else
            echo "  tor"
    fi
else
    echo ""
fi
