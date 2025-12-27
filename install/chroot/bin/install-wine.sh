#!/bin/bash

# Author: Nate Cheney
# Filename: install-wine.sh
# Description: This script installs wine and winetricks. 
# Usage: sudo ./install-wine.sh
# Options:
#

package="wine winetricks"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

