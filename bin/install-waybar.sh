#!/bin/bash

# Author: Nate Cheney
# Filename: install-waybar.sh
# Description: This script installs waybar. 
# Usage: sudo ./install-waybar.sh
# Options:
#

package="waybar"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
