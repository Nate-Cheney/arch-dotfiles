#!/bin/bash

# Author: Nate Cheney
# Filename: _install-package.sh
# Description: This script serves as a template for installing packages with pacman 
# Usage: sudo ./_install-package.sh
# Options:
#

package=""

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
