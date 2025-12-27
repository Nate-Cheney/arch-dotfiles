#!/bin/bash

# Author: Nate Cheney
# Filename: boot.sh 
# Description: 
#   This scipt interactively gathers information
#   clones the dotfiles repo and runs the main install script
# Usage: ./boot.sh
# Options:
#

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Get host and user names from user
while true; do    
    read -p "Enter the desired hostname:" HOST_NAME
    read -p "Enter the desired username:" USERNAME
    echo
    read -p "Are the following correct (y/n)? hostname: $HOST_NAME \nusername: $USERNAME" yesno
    case $yesno in
        [Yy]* )
            echo -e "\nContinuing with the install"
            export HOST_NAME
            export USERNAME
            break 
        ;;
        [Nn]* )
            echo -e "\nTry again"
        ;;
        * ) echo "Enter either y or n";;
    esac
done

pacman -Syu --noconfirm git

echo -e "\nCloning https://github.com/Nate-Cheney/arch-dotfiles.git"
rm -rf ./arch-dotfiles/
git clone "https://github.com/Nate-Cheney/arch-dotfiles.git" > dev/null

cd arch-dotfiles
echo -e "\nBeginning install..."
./install.sh
cd ..

