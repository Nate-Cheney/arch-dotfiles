#!/bin/bash

# Author: Nate Cheney
# Filename: run-install-scripts.sh
# Description: This is the masters install script that will run all install-<pkg>.sh scripts. 
# Usage: ./run-install-scripts.sh
# Options:
#

sudo -v

if [ ! -d "bin" ] || [ ! -f "bin/install-git.sh" ]; then
    echo "Error: must be run from the arch-dotfiles repository root"
    exit 1
fi

echo "Updating pacman manifest"
sudo pacman -Sy

echo "Installing git"
bash "bin/install-git.sh"

echo "Running yay installer" 
bash "bin/install-yay.sh"

for file in bin/install-*.sh; do
    if [ -f "$file" ] && [[ "$file" != "bin/install-yay.sh" && "$file" != "bin/install-git.sh" && "$file" != "bin/install-intel_gpu" ]]; then
        echo "Running: $file"
        bash "$file"
    fi
done

