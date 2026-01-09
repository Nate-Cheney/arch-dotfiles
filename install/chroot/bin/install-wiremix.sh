#!/bin/bash

# Author: Nate Cheney
# Filename: install-wiremix.sh
# Description: This script installs the wiremix sound manager and the pipewire dependencies. 
# Usage: sudo ./install-wiremix.sh
# Options:
#

package="alsa-utils alsa-ucm-conf pipewire pipewire-alsa pipewire-pulse sof-firmware wiremix wireplumber"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

systemctl --user enable wireplumber pipewire pipewire-pulse
