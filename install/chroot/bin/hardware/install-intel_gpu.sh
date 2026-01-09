#!/bin/bash

# Author: Nate Cheney
# Filename: install-intel_gpu.sh
# Description: 
#   This script ensures that the necessary packages are installed for an Intel Arc GPU.   
#   See https://wiki.archlinux.org/title/Intel_graphics for more information.
# Usage:  sudo ./install-intel_gpu.sh
# Options:
#

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo ./install-intel_gpu.sh)"
    exit 1
fi

packages=(mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver intel-gpu-tools)
    
if ! pacman -Q "${packages[@]}" &> /dev/null; then
    echo "Installing $package..."
    pacman -S --noconfirm --needed "${packages[@]}"
else 
    echo "Intel GPU packages already installed."
fi

echo "Backing up mkinitcpio..."
cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak

echo "Ensuring nvidia drivers are loaded during boot..."
sed -i "/^MODULES=([^)]*\bxe\b[^)]*)/! s/^MODULES=([^)]*/& xe/" /etc/mkinitcpio.conf

echo "Regenerating initramfs..."
mkinitcpio -P

