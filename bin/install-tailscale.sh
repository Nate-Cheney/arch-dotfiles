#!/bin/bash

# Author: Nate Cheney
# Filename: install-tailscale.sh
# Description: This script installs and starts tailscale. 
# Usage: sudo ./install-tailscale.sh
# Options:
#

package="tailscale"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

# Start tailscale
sudo systemctl start tailscaled
sudo systemctl enable tailscaled

sudo tailscale up --accept-routes
