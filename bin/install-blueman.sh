#!/bin/bash

# Author: Nate Cheney
# Filename: install-blueman.sh
# Description: This script installs the blueman package. 
# Usage: sudo ./install-blueman.sh
# Options:
#

package="blueman"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
