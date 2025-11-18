#!/bin/bash

# Author: Nate Cheney
# Filename: install-openssh.sh
# Description: This script installs openssh and enables and starts the service.
# Usage: sudo ./install-openssh.sh
# Options:
#

# Install
package="openssh"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

# Enable & start
systemctl enable sshd.service
systemctl start sshd.service

