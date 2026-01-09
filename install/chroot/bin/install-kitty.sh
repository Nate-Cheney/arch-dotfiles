#!/bin/bash

# Author: Nate Cheney
# Filename: install-kitty.sh
# Description: This script installs the kitty terminal emulator. 
# Usage: sudo ./install-kitty.sh
# Options:
#

package="kitty"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

