#!/bin/bash

# Author: Nate Cheney
# Filename: run-install-scripts.sh
# Description: This is the masters install script that will run all install-<pkg>.sh scripts. 
# Usage: ./run-install-scripts.sh
# Options:
#

sudo -v

echo "Updating pacman manifest"
sudo pacman -Sy

echo "Installing git"
bash "~/Dev/arch-dotfiles/bin/install-git.sh"

echo "Running yay installer" 
bash "~/Dev/arch-dotfiles/bin/install-yay.sh"

for file in ~/Dev/arch-dotfiles/bin/install-*.sh; do
    if [ -f "$file" ] && [[ "$file" != "~/Dev/arch-dotfiles/bin/install-yay.sh" && "$file" != "~/Dev/arch-dotfiles/bin/install-git.sh" ]]; then
        echo "Running: $file"
        bash "$file"
    fi
done

