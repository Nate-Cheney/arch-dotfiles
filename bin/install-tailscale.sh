#!/bin/bash

# Author: Nate Cheney
# Filename: install-tailscale.sh
# Description: This script installs and starts tailscale. 
# Usage: sudo ./install-tailscale.sh
# Options:
#

package="tailscale"

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

# Start tailscale
systemctl start tailscaled
systemctl enable tailscaled

tailscale up --accept-routes
