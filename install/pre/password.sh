#!/bin/bash

# Author: Nate Cheney
# Filename: password.sh 
# Description: Gets the root and user password.
# Usage: ./password.sh
# Options:
#

# -- Get root password --
while true; do
    read -s -p "Enter root password: " ROOT_PASS
    echo
    if [ -z "$ROOT_PASS" ]; then
        echo "Password cannot be empty. Try again."
        continue
    fi
    read -s -p "Confirm root password: " ROOT_PASS_CONFIRM
    echo
    if [ "$ROOT_PASS" == "$ROOT_PASS_CONFIRM" ]; then
        break
    else
        echo "Passwords do not match. Try again."
    fi
done

# -- Get user password --
while true; do
    read -s -p "Enter $USERNAME password: " USER_PASS
    echo
    if [ -z "$USER_PASS" ]; then
        echo "Password cannot be empty. Try again."
        continue
    fi
    read -s -p "Confirm $USERNAME password: " USER_PASS_CONFIRM
    echo
    if [ "$USER_PASS" == "$USER_PASS_CONFIRM" ]; then
        break
    else
        echo "Passwords do not match. Try again."
    fi
done

