#!/bin/bash

# Author: Nate Cheney
# Filename: install-wine.sh
# Description: This script installs wine and winetricks. 
# Usage: sudo ./install-wine.sh
# Options:
#

package="wine winetricks"

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
