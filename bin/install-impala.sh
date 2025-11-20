#!/bin/bash

# Author: Nate Cheney
# Filename: install-impala.sh
# Description: This script installs impala and iwd and enables the iwd service.
# Usage: sudo ./install-impala.sh
# Options:
#

package="impala iwd"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

sudo systemctl enable iwd
sudo systemctl start iwd
