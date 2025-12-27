#!/bin/bash

# Author: Nate Cheney
# Filename: install-obsidian.sh
# Description: This script installs Obsidian.
# Usage: sudo ./install-obsidian.sh
# Options:
#

package="obsidian"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

