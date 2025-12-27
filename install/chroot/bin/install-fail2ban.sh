#!/bin/bash

# Author: Nate Cheney
# Filename: install-fail2ban.sh
# Description: This script installs and enables fail2ban. 
# Usage: sudo ./install-fail2ban.sh
# Options:
#

package="fail2ban"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

sudo systemctl enable fail2ban.service

