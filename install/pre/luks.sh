#!/bin/bash

# Author: Nate Cheney
# Filename: luks.sh 
# Description: Prerequisite script that gets the LUKS passphrase. 
# Usage: ./luks.sh
# Options:
#

# Get LUKS passphrase
while true; do
    read -s -p "Enter LUKS passphrase: " LUKS_PASS
    echo
    if [ -z "$LUKS_PASS" ]; then
        echo "Passphrase cannot be empty. Try again."
        continue
    fi
    read -s -p "Confirm LUKS passphrase: " LUKS_PASS_CONFIRM
    echo
    if [ "$LUKS_PASS" == "$LUKS_PASS_CONFIRM" ]; then
        break
    else
        echo "Passphrases do not match. Please try again."
    fi
done

