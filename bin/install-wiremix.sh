#!/bin/bash

# Author: Nate Cheney
# Filename: install-wiremix.sh
# Description: This script installs the wiremix sound manager. 
# Usage: sudo ./install-wiremix.sh
# Options:
#

package=""

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

