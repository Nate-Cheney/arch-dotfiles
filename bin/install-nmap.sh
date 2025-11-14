#!/bin/bash

# Author: Nate Cheney
# Filename: install-nmap.sh
# Description: This script installs nmap. 
# Usage: sudo ./install-nmap.sh
# Options:
#

package="nmap"

if [ $EUID -ne 0 ]; then 
    echo "This script must be run as root."
    exit 1
fi

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
