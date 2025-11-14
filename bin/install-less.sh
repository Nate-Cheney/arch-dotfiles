#!/bin/bash

# Author: Nate Cheney
# Filename: install-less.sh
# Description: This script installs the less terminal emulator. 
# Usage: sudo ./install-less.sh
# Options:
#

package="less"

if [ $EUID -ne 0 ]; then 
    echo "This script must be run as root."
    exit 1
fi

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
