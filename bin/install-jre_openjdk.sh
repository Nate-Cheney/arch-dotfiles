#!/bin/bash

# Author: Nate Cheney
# Filename: install-jre_openjdk.sh
# Description: This script installs the Java runtime env open JDK package. 
# Usage: sudo ./install-jre_openjdk.sh
# Options:
#

package="jre-openjdk"

if [ $EUID -ne 0 ]; then 
    echo "This script must be run as root."
    exit 1
fi

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi
