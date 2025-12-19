!#/bin/bash

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
    read -p "\nEnter the desired hostname:\n" SYSNAME
    read -p "\nEnter the desired username:\n" USERNAME
    read -p "\nAre the following correct (y/n)? \nhostname: $SYSNAME \nusername: $USERNAME \n" yesno
    case $yesno in
        [Yy]* )
            echo -e "\nContinuing with the install"
            export SYSNAME="$SYSNAME"
            export USERNAME="$USERNAME"
            exit
        ;;
        [Nn]* )
            echo -e "\nTry again"
        ;;
        * ) "Enter either y or n";;
    esac
done

pacman -Syu git

echo -e "\nCloning https://github.com/Nate-Cheney/arch-dotfiles.git"
rm -rf ./arch-dotfiles/
git clone "https://github.com/Nate-Cheney/arch-dotfiles.git" > dev/null

echo -e "\nBeginning install..."
source arch-dotfiles/install.sh

