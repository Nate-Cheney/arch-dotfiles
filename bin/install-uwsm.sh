#!/bin/bash

# Author: Nate Cheney
# Filename: install-uwsm.sh
# Description: This script installs universal wayland session manager. 
# Usage: sudo ./install-uwsm.sh
# Options:
#

package="uwsm"

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
