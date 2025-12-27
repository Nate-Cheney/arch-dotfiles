#!/bin/bash

# Author: Nate Cheney
# Filename: install-zen_browser.sh
# Description: This script installs zen browser. 
# Usage: sudo ./install-zen_browser.sh
# Options:
#

package="zen-browser-bin"

echo "Installing $package"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "$package"

