#!/bin/bash

# Author: Nate Cheney
# Filename: install-man.sh
# Description: This script installs the packages required for the man command. 
# Usage: sudo ./install-man.sh
# Options:
#

package="man-db man-pages"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

