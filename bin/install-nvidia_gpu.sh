#!/bin/bash

# Author: Nate Cheney
# Filename: install-nvidia_gpu.sh
# Description: 
#   This script ensures that the necessary packages are installed for a Nvidia GPU.
#   See https://wiki.archlinux.org/title/Intel_graphics for more information.
# Usage:  sudo ./install-nvidia_gpu.sh
# Options:
#

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo ./install-nvidia_gpu.sh)"
    exit 1
fi

# Install packages
packages=(linux-firmware-nvidia nvidia-open nvidia-settings nvidia-utils)

if ! pacman -Q "${packages[@]}" &> /dev/null; then
    echo "Installing $package..."
    pacman -S --noconfirm --needed "${packages[@]}"
else 
    echo "Intel GPU packages already installed."
fi

# Configure initramfs modules
if ! grep -q "nvidia" /etc/mkinitcpio.conf; then
    echo "Nvidia modules not found in mkinitcpio config. Adding them..."
    
    # Create mkinitcpio backup
    cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak

    # Insert nvidia modules
    sed -i "s/^MODULES=(\(.*\))/MODULES=(\1 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/" /etc/mkinitcpio.conf

    # Clean up any potential double spaces if the array was originally empty 
    sed -i 's/MODULES=( /MODULES=(/' /etc/mkinitcpio.conf

    echo "Regenerating initramfs..."
    mkinitcpio -P
fi

