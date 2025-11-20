#!/bin/bash

# Author: Nate Cheney
# Filename: install-sddm.sh
# Description: This script installs simple desktop display manager. 
# Usage: sudo ./install-sddm.sh
# Options:
#

package="sddm"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

sudo systemctl enable sddm
