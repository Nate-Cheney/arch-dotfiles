#!/bin/bash

# Author: Nate Cheney
# Filename: timezone.sh 
# Description: Prerequisite script that gets the timezone. 
# Usage: ./timezone.sh
# Options:
#

# Check unattend.json
if [ -f "unattend.json" ]; then
    unattend_timezone=$(jq -r ".timezone" unattend.json)

    if timedatectl list-timezones | grep -qx "$unattend_timezone"; then
        echo "Unattend timezone: $unattend_timezone exists"
        TIMEZONE=$unattend_timezone
        export $TIMEZONE
        return
    fi
fi

# Get timezone with IP API
api_timezone=$(curl https://ipapi.co/timezone)
if timedatectl list-timezones | grep -qx "$api_timezone"; then
    echo "IP API timezone: $api_timezone exists"
    TIMEZONE=$api_timezone
    export $TIMEZONE
    return
fi

# Default
TIMEZONE="America/New_York"
export $TIMEZONE

