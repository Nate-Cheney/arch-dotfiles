#!/bin/bash

# Author: Nate Cheney
# Filename: install-power_profiles.sh
# Description: This script installs the power profiles daemon and enables it 
# Usage: sudo ./_install-power_profiles.sh
# Options:
#

package="power-profiles-daemon"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

sudo systemctl enable power-profiles-daemon

