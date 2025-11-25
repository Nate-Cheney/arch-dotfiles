#!/bin/bash

# Author: Nate Cheney
# Filename: install-pwvu.sh
# Description: This script installs Pipewire volume control. 
# Usage: sudo ./install-pwvu.sh
# Options:
#

package="alsa-utils alsa-ucm-conf pwvucontrol pipewire pipewire-alsa pipewire-pulse sof-firmware wireplumber"

echo "Installing $package"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "$package"

systemctl --user enable wireplumber pipewire pipewire-pulse
systemctl --user start wireplumber pipewire pipewire-pulse
