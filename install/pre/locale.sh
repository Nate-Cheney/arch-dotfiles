#!/bin/bash

# Author: Nate Cheney
# Filename: locale.sh 
# Description: Prerequisite script that gets the locale for the system. 
# Usage: ./locale.sh
# Options:
#

# Check unattend.json
if [ -f "unattend.json" ]; then
    unattend_locale=$(jq -r ".locale // empty" unattend.json)
    if [[ -n "$unattend_locale" ]]; then 
        LOCALE=$unattend_locale
        export LOCALE
        return
    fi
fi

LOCALE="en_US.UTF-8"
export LOCALE

