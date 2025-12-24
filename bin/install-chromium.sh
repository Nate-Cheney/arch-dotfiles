#!/bin/bash

# Author: Nate Cheney
# Filename: install-chromium.sh
# Description: This script installs chromium and widevine for DRM.
# Usage: sudo ./install-chromium.sh
# Options:
#

packages=(chromium chromium-widevine)

if ! pacman -Q "${packages[@]}" &> /dev/null; then
    echo "Installing $package..."
    pacman -S --noconfirm --needed "${packages[@]}"
else 
    echo "${packages[@]} are already installed"
fi

