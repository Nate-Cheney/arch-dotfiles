#!/bin/bash

# Author: Nate Cheney
# Filename: install-gnome_keyring.sh
# Description: This script installs the gnome keyring. 
# Usage: sudo ./install-gnome_keyring.sh
# Options:
#

package="gnome-keyring"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
