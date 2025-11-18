#!/bin/bash

# Author: Nate Cheney
# Filename: install-proton_pass.sh
# Description: This script installs proton pass. 
# Usage: sudo ./install-proton_pass.sh
# Options:
#

package="proton-pass-bin"

echo "Installing $package"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "$package"

