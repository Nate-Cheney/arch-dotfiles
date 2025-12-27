#!/bin/bash

# Author: Nate Cheney
# Filename: locale.sh 
# Description: Prerequisite script that gets the locale for the system. 
# Usage: ./locale.sh
# Options:
#

# Check unattend.json
if [ -f "unattend.json" ]; then
    unattend_locale=$(jq -r ".locale" unattend.json)
    LOCALE=$unattend_locale
    export LOCALE
    return
fi

LOCALE="en_US.UTF-8"
export LOCALE

