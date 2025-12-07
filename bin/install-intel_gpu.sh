#!/bin/bash

# Author: Nate Cheney
# Filename: install-intel_gpu.sh
# Description: 
#   This script ensures that the necessary packages are installed for an Intel Arc GPU.   
#   See https://wiki.archlinux.org/title/Intel_graphics for more information.
# Usage: sudo ./install-intel_gpu.sh
# Options:
#   -c (cleans up old nvidia config and packages)
#

main() {
    packages=(mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver)
    
    if ! pacman -Q $package &> /dev/null; then
        echo "Installing $package..."
        sudo pacman -S --noconfirm --needed "${packages[@]}"
    else 
        echo "$package is already installed."
    fi
}

usage() {
	cat << EOF
Usage: ./install-intel_gpu.sh

Options:
  -c cleans up old nvidia config and packages, updates mkinitcpio

EOF
	exit 0
}

clean() {
    main

    # Remove nvidia packages
    if pacman -Qs nvidia > /dev/null; then
        sudo pacman -Rns --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings 2>/dev/null || echo "Some nvidia packages not found, proceeding..."
    fi

    # Backup and replace nvidia modules with xe
    sudo cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
    sudo sed -i 's/^MODULES=(.*nvidia.*)/MODULES=(xe)/' /etc/mkinitcpio.conf

    echo "Regenerating initramfs..."
    sudo mkinitcpio -P

}

# No option run main
if [ $# -eq 0 ]; then
    main
fi

# Handle options
while getopts "hdu" opt; do
	case $opt in
		h)
			usage 
		;;
		c)
			clean
		;;
		\?)
			echo "Invalid option: $OPTARG" >&2
			exit 1
		;;
	esac
done

