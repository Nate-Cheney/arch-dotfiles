#!/bin/bash

# Author: Nate Cheney
# Filename: install-pwvu.sh
# Description: This script installs Pipewire volume control. 
# Usage: sudo ./install-pwvu.sh
# Options:
#

package="alsa-utils alsa-ucm-conf pipewire pipewire-alsa pipewire-pulse sof-firmware wireplumber"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

echo "Installing pwvucontrol"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "pwvucontrol"

systemctl --user enable wireplumber pipewire pipewire-pulse
systemctl --user start wireplumber pipewire pipewire-pulse
