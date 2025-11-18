#!/bin/bash

# Author: Nate Cheney
# Filename: install-fonts.sh
# Description: This script installs the fonts I use on my system. 
# Usage: sudo ./install-fonts.sh
# Options:
#

package="noto-fonts-emoji ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-liberation"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi


package="ttf-ms-win11-auto"

echo "Installing $package"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "$package"

echo "Clearing font cache"
fc-cache -fv

