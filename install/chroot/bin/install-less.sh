#!/bin/bash

# Author: Nate Cheney
# Filename: install-less.sh
# Description: This script installs the less terminal emulator. 
# Usage: sudo ./install-less.sh
# Options:
#

package="less"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

