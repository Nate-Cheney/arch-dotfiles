#!/bin/bash

# Author: Nate Cheney
# Filename: install-thunar.sh
# Description: This script installs the thunar file manager 
# Usage: sudo ./hide-walker-apps.sh
# Options:
#

if [ $EUID -ne 0 ]; then 
    echo "This script must be run as root."
    exit 1
fi

if ! pacman -Q thunar &> /dev/null; then
    echo "Installing thunar..."
    pacman -S --noconfirm --needed thunar
else 
    echo "Thunar is already installed."
fi

