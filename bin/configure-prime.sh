#!/bin/bash

# Author: Nate Cheney
# Filename: enable-prime.sh 
# Description: 
#   This installs and configures the necessary packages for PRIME GPU offloading.
#   
#   This prevents hyprland and other apps from natively using the GPU
#   which allows it to enter a low power state to conserve battery.
#
#   Note: in order to allow an app to use the GPU, it must be run with `prime-run ` as a prefix. 
#
# Usage: sudo ./enable-prime.sh
# Options:
#

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo ./enable-prime.sh)"
    exit 1
fi

# Install packages
packages=(nvidia nvidia-prime nvidia-utils lib32-nvidia-utils)

if ! pacman -Q "${packages[@]}" &> /dev/null; then
    echo "Installing $package..."
    pacman -S --noconfirm --needed "${packages[@]}"
else 
    echo "Intel GPU packages already installed."
fi

# Enable power management
echo "options nvidia NVreg_DynamicPowerManagement=0x02" > /etc/modprobe.d/nvidia-pm.conf

# Enable required services
systemctl enable nvidia-persistenced
systemctl enable nvidia-suspend
systemctl enable nvidia-hibernate
systemctl enable nvidia-resume

# Ensure drivers are loaded at boot
echo "Backing up mkinitcpio..."
cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak

echo "Ensuring nvidia drivers are loaded during boot..."
sed -i "/^MODULES=([^)]*\bnvidia nvidia_modeset nvidia_uvm nvidia_drm\b[^)]*)/! s/^MODULES=([^)]*/& nvidia nvidia_modeset nvidia_uvm nvidia_drm/" /etc/mkinitcpio.conf

echo "Regenerating initramfs..."
mkinitcpio -P

# Enable kernal modesetting
sed -i "/options cryptdevice=UUID=.*?:cryptroot root=\/dev\/mapper\/cryptroot rw/ { /nvidia_drm.modeset=1/ !s/rw/rw nvidia_drm.modeset=1 nvidia_drm.fbdev=1/ }" /boot/loader/entries/arch.conf

# Configure hyprland
echo 'export AQ_DRM_DEVICES="/dev/dri/card1"' > $HOME/.config/uwsm/env-hyprland
echo "export _EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json" > $HOME/.config/uwsm/nvidia

echo "PRIME GPU offloading will be enabled after rebooting your device."

