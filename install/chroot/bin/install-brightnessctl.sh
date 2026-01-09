#!/bin/bash

# Author: Nate Cheney
# Filename: install-brightnessctl.sh
# Description: This script installs brightnessctl. 
# Usage: sudo ./install-brightnessctl.sh
# Options:
#

package="brightnessctl"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

