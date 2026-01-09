#!/bin/bash

# Author: Nate Cheney
# Filename: hostname.sh 
# Description: Prerequisite script that gets the desired hostname and non-root username.
# Usage: ./hostname.sh
# Options:
#

# Check unattend.json
if [ -f "unattend.json" ]; then
    unattend_hostname=$(jq -r ".hostname // empty" unattend.json)
    if [[ -n "$unattend_hostname" ]]; then
        HOST_NAME="$unattend_hostname"
    fi

    unattend_username=$(jq -r ".username // empty" unattend.json)
    if [[ -n "$unattend_username" ]]; then
        USERNAME="$unattend_username"
    fi
fi

# Interactively get hostname
if [[ -z  "$HOST_NAME" ]]; then
    while true; do    
        read -p "Enter the desired hostname:" HOST_NAME
        echo
        read -p "Is the hostname correct (y/n)? hostname: $HOST_NAME " yesno
        case $yesno in
            [Yy]* )
                echo "Hostname set"
                export HOST_NAME
                break 
            ;;
            [Nn]* )
                echo -e "\nTry again"
            ;;
            * ) echo "Enter either y or n";;
        esac
    done
fi

# Interactively get username 
if [[ -z "$USERNAME" ]]; then
    while true; do    
        read -p "Enter the desired username:" USERNAME
        echo
        read -p "Is the username correct (y/n)? $USERNAME " yesno
        case $yesno in
            [Yy]* )
                echo "Username set"
                export USERNAME
                break 
            ;;
            [Nn]* )
                echo -e "\nTry again"
            ;;
            * ) echo "Enter either y or n";;
        esac
    done
fi

