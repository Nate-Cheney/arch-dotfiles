#!/bin/bash

# Author: Nate Cheney
# Filename: _install-package.sh
# Description: This script serves as a template for installing packages with pacman 
# Usage: sudo ./_install-package.sh
# Options:
#

package=""

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
