#!/bin/bash

# Author: Nate Cheney
# Filename: password.sh 
# Description: Gets the root and user password.
# Usage: ./password.sh
# Options:
#

# Check unattend.json
if [ -f "unattend.json" ]; then
    unattend_root=$(jq -r ".rootpass // empty" unattend.json)
    if [[ -n "$unattend_root" ]]; then
        ROOT_PASS="$unattend_root"
    fi

    unattend_user=$(jq -r ".userpass // empty" unattend.json)
    if [[ -n "$unattend_user" ]]; then
        USER_PASS="$unattend_user"
    fi
fi


# Interactively get root password
if [[ -z  "$ROOT_PASS" ]]; then
    while true; do
        read -s -p "Enter root password: " ROOT_PASS
        if [ -z "$ROOT_PASS" ]; then
            echo "Password cannot be empty. Try again."
            continue
        fi
        read -s -p "Confirm root password: " ROOT_PASS_CONFIRM
        if [ "$ROOT_PASS" == "$ROOT_PASS_CONFIRM" ]; then
            export ROOT_PASS
            echo "Root passwords match."
            break
        fi
        echo "Passwords do not match. Try again."
    done
fi

# Interactively get user password
if [[ -z  "$USER_PASS" ]]; then
    while true; do
        read -s -p "Enter $USERNAME password: " USER_PASS
        if [ -z "$USER_PASS" ]; then
            echo "Password cannot be empty. Try again."
            continue
        fi
        read -s -p "Confirm $USERNAME password: " USER_PASS_CONFIRM
        if [ "$USER_PASS" == "$USER_PASS_CONFIRM" ]; then
            export USER_PASS
            echo "User passwords match"
            break
        fi
        echo "Passwords do not match. Try again."
    done
fi

