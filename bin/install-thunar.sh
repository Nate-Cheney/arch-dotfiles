#!/bin/bash

# Author: Nate Cheney
# Filename: install-thunar.sh
# Description: This script installs the thunar file manager 
# Usage: sudo ./install-thunar.sh
# Options:
#

package="gvfs thunar"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package already installed."
fi

