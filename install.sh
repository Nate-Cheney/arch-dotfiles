#!/bin/bash

# Author: Nate Cheney
# Filename: install.sh 
# Description: 
#   This script clones the dotfiles repo,
#   runs the pre-requisite scripts (gathers info from unattend.json or interactively),
#   and runs the main install script.
#   
# Usage: ./install.sh
# Options:
#

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

pacman -Syu --noconfirm git

echo -e "\nCloning https://github.com/Nate-Cheney/arch-dotfiles.git"
rm -rf ./arch-dotfiles/
git clone "https://github.com/Nate-Cheney/arch-dotfiles.git" > dev/null
cd arch-dotfiles

echo -e "\nBeginning install..."

# -- Pre-requisites 
source "./install/pre/main.sh"

# -- Main process
source "./install/main/main.sh"

