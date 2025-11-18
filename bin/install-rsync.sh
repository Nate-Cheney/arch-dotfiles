#!/bin/bash

# Author: Nate Cheney
# Filename: install-rsync.sh
# Description: This script installs the rsync package. 
# Usage: sudo ./install-rsync.sh
# Options:
#

package="rsync"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
