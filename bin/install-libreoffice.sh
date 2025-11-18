#!/bin/bash

# Author: Nate Cheney
# Filename: install-libreoffice.sh
# Description: This script installs the nightly version of the libreoffice apps. 
# Usage: sudo ./install-libreoffice.sh
# Options:
#

package="libreoffice-nightly hunspell-en_u"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
