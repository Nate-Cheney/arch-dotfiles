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
    package="mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver"
    
    if ! pacman -Q $package &> /dev/null; then
        echo "Installing $package..."
        sudo pacman -S --noconfirm --needed $package
    else 
        echo "$package is already installed."
    fi
}

usage() {
	cat << EOF
Usage: ./install-intel_gpu.sh

Options:
  -c (cleans up old nvidia config and packages)

EOF
	exit 0
}

clean() {
    main

    # Replace nvidia modules with xe
    sudo sed -i "s/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/MODULES=(xe)" 

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

