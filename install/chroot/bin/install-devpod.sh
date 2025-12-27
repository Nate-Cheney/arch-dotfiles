#!/bin/bash

# Author: Nate Cheney
# Filename: install-devpod.sh
# Description: This script installs devpod-cli-bin and adds a bash alias. 
# Usage: sudo ./install-devpod.sh
# Options:
#

package="devpod-cli-bin"

echo "Installing $package"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "$package"

if ! grep -q "alias devpod='devpod-cli'" "$HOME/.bashrc"; then
    echo "Adding devpod alias to bashrc."
    echo "alias devpod='devpod-cli'" >> $HOME/.bashrc
fi    

devpod provider add docker

