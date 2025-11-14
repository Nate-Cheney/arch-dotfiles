#!/bin/bash

# Author: Nate Cheney
# Filename: install-hyprapps.sh
# Description: This script serves as a template for installing packages with pacman 
# Usage: sudo ./install-hyprapps.sh
# Options:
#

package="hyprcursor hyprgraphics hypridle hyprland hyprland-guiutils hyprlang hyprpaper hyprshot hyprsunset hyprutils hyprwayland-scanner xdg-desktop-portal-hyprland"

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
