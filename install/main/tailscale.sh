#!/bin/bash

# Author: Nate Cheney
# Filename: tailscale.sh 
# Description: Creates `tailscale_auth.sh` if a key is supplied to be sourced while tailscale is being installed. 
#
# Usage: ./tailscale.sh
# Options:
#

# Check unattend.json
if [ -f "unattend.json" ]; then
    unattend_tailscale=$(jq -r ".tailscale // empty" unattend.json)
    if [[ -n "$unattend_tailscale" ]]; then 
        TS_AUTH="$unattend_tailscale"
        echo "TS_AUTH=$TS_AUTH" > /mnt/root/tailscale_auth.sh
    fi
fi

