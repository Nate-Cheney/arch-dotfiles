#!/bin/bash

# Author: Nate Cheney
# Filename: install-spotify.sh
# Description: This script installs the spotify launcher. 
# Usage: sudo ./install-spotify.sh
# Options:
#

package="spotify-launcher"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

