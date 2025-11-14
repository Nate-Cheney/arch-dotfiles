#!/bin/bash

# Author: Nate Cheney
# Filename: install-system_menu.sh
# Description: This script installs a number of packages required for the system, power, and clipboard menus. 
# Usage: sudo ./_install-system_menu.sh
# Options:
#

packages=(
    "cliphist"
    "elephant-bin"
    "elephant-clipboard-bin"
    "elephant-desktopapplications-bin"
    "walker-bin"
)

# Install applications
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "${packages[@]}"

# Start elephant
elephant service enable
systemctl --user start elephant.service

