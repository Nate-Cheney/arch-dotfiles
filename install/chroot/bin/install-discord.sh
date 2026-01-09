#!/bin/bash

# Author: Nate Cheney
# Filename: install-discord.sh
# Description: This script installs discord. 
# Usage: sudo ./install-discord.sh
# Options:
#

package="discord"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

