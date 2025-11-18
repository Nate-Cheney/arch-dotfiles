#!/bin/bash

# Author: Nate Cheney
# Filename: install-neovim.sh
# Description: This script installs neovim 
# Usage: sudo ./install-neovim.sh
# Options:
#

package="neovim"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

