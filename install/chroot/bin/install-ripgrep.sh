#!/bin/bash

# Author: Nate Cheney
# Filename: install-ripgrep.sh
# Description: 
#   This script installs ripgrep which is a re-write of grep in rust. 
#   Ripgrep is used by the grep plugin I use in neovim. 
# Usage: sudo ./install-ripgrep.sh
# Options:
#

package="ripgrep"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

