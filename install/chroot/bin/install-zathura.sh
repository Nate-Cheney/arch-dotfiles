#!/bin/bash

# Author: Nate Cheney
# Filename: install-zathura.sh
# Description: This script installs zathura; a document viewer.
# Usage: sudo ./install-zathura.sh
# Options:
#

package="zathura zathura-pdf-mupdf"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi


mkdir -p "$HOME/.config/zathura/"
echo "set selection-clipboard clipboard" > "$HOME/.config/zathura/zathurarc"

