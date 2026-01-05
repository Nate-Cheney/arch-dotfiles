#!/bin/bash

# Author: Nate Cheney
# Filename: install-docker.sh
# Description: This script installs docker and docker compose. 
# Usage: sudo ./install-docker.sh
# Options:
#

package="docker docker-compose"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

if pacman -Q docker &> /dev/null; then
    # Enable docker 
    sudo systemctl enable docker

    # Add user to docker group
    sudo groupadd docker
    sudo usermod -aG docker $USER
fi

