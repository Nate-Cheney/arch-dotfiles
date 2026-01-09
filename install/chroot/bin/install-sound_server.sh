#!/bin/bash

# Author: Nate Cheney
# Filename: install-sound_server.sh
# Description: This script installs playerctl as a sound server and pwvucontrol as a gui manager. 
# Usage: sudo ./install-devpod.sh
# Options:
#

package="playerctl pwvucontrol"

echo "Installing $package"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "$package"

