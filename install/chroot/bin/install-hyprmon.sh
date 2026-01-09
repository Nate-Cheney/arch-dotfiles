#!/bin/bash

# Author: Nate Cheney
# Filename: install-hyprmon.sh
# Description: This script installs the hyprmon TUI monitor manager.
# Usage: sudo ./install-hyprmon.sh
# Options:
#

package="hyprmon-bin"

echo "Installing $package"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "$package"

