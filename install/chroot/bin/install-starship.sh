#!/bin/bash

# Author: Nate Cheney
# Filename: install-starship.sh
# Description: This script installs starship and adds it to the bashrc file. 
# Usage: sudo ./install-starship.sh
# Options:
#

package="starship"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

if ! grep -q 'eval "$(starship init bash)"' $HOME/.bashrc; then
    echo 'eval "$(starship init bash)"' >> $HOME/.bashrc
fi

