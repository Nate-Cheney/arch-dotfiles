#!/bin/bash

# Author: Nate Cheney
# Filename: install-tmux.sh
# Description: This script installs tmux. 
# Usage: sudo ./install-tmux.sh
# Options:
#

package="tmux"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
