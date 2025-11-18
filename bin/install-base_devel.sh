#!/bin/bash

# Author: Nate Cheney
# Filename: install-base_devel.sh
# Description: This script installs the base-devel package. 
# Usage: sudo ./install-base_devel.sh
# Options:
#

package="base-devel"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

