#!/bin/bash

# Author: Nate Cheney
# Filename: install-pwvu.sh
# Description: This script installs Pipewire volume control. 
# Usage: sudo ./install-pwvu.sh
# Options:
#

package="pwvucontrol"

echo "Installing $package"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "$package"
