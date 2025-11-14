#!/bin/bash

# Author: Nate Cheney
# Filename: install-fail2ban.sh
# Description: This script installs fail2ban. 
# Usage: sudo ./install-fail2ban.sh
# Options:
#

package="fail2ban"

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
