#!/bin/bash

# Author: Nate Cheney
# Filename: install-nmap.sh
# Description: This script installs nmap. 
# Usage: sudo ./install-nmap.sh
# Options:
#

package="nmap"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

