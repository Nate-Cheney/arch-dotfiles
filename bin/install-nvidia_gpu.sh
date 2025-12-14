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



echo "Backing up mkinitcpio..."
cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak

echo "Ensuring nvidia drivers are loaded during boot..."
sed -i "/^MODULES=([^)]*\bnvidia nvidia_modeset nvidia_uvm nvidia_drm\b[^)]*)/! s/^MODULES=([^)]*/& nvidia nvidia_modeset nvidia_uvm nvidia_drm/" /etc/mkinitcpio.conf

echo "Regenerating initramfs..."
mkinitcpio -P

