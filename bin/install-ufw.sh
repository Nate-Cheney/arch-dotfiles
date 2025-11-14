#!/bin/bash

# Author: Nate Cheney
# Filename: install-ufw.sh
# Description: This script installs, configures, and enables ufw.
# Usage: sudo ./install-ufw.sh
# Options:
#

package="ufw"

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

# Configure and enable ufw
ufw default deny incoming
ufw default allow outgoing

ufw allow 22
ufw allow 80
ufw allow 443

sudo ufw enable
