#!/bin/bash

# Author: Nate Cheney
# Filename: _install-package.sh
# Description: This script serves as a template for installing packages with pacman 
# Usage: sudo ./_install-package.sh
# Options:
#

if [ $EUID -ne 0 ]; then 
    echo "This script must be run as root."
    exit 1
fi

depencencies=(
    "base-devel"
    "git"
)

for dep in $dependencies; do 
    if ! pacman -Q $dep &> /dev/null; then
        echo "Installing $dep..."
        pacman -S --noconfirm --needed $dep
    fi
done

# Clone and install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Ensure yay was installed
if command -v yay &> /dev/null; then
    echo "Yay is installed."

else
    echo "Yay was not installed properly."
    exit 1
fi

