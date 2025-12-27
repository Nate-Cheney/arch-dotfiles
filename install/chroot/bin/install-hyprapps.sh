#!/bin/bash

# Author: Nate Cheney
# Filename: install-hyprapps.sh
# Description: This script serves as a template for installing packages with pacman 
# Usage: sudo ./install-hyprapps.sh
# Options:
#

package="hyprcursor hyprgraphics hypridle hyprland hyprland-guiutils hyprlang hyprlock hyprpaper hyprshot hyprsunset hyprutils hyprwayland-scanner xdg-desktop-portal-hyprland"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

