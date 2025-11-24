#!/bin/bash

# Author: Nate Cheney
# Filename: _install-package.sh
# Description: This script serves as a template for installing packages with pacman 
# Usage: sudo ./_install-package.sh
# Options:
#


dependencies=(
    "base-devel"
    "git"
)

for dep in "${dependencies[@]}"; do 
    if ! pacman -Q $dep &> /dev/null; then
        echo "Installing $dep..."
        sudo pacman -S --noconfirm --needed $dep
    fi
done


if ! pacman -Q yay &> /dev/null; then
    original_dir=$PWD
    cd $HOME
    echo "Cloning Yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    echo "Building Yay..."
    makepkg -si
    cd $original_dir

    # Ensure yay was installed
    if command -v yay &> /dev/null; then
        echo "Yay is installed."
    
    else
        echo "Yay was not installed properly."
        exit 1
    fi

else
    echo "Yay is already installed... skipping."    

fi


