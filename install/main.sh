#!/bin/bash

# Author: Nate Cheney
# Filename: main.sh 
# Description: This is the main script to be ran when installing Arch Linux. 
# Usage: ./main.sh
# Options:
#

set -e
set -o pipefail

# -- Environment Variables --
source install/config.sh

# -- Get root password --
while true; do
    read -s -p "Enter root password:" ROOT_PASS
    echo
    if [ -z "$ROOT_PASS" ]; then
        echo "Password cannot be empty. Try again."
        continue
    fi
    read -s -p "Confirm root password:" ROOT_PASS_CONFIRM
    echo
    if [ "$ROOT_PASS" == "$ROOT_PASS_CONFIRM" ]; then
        break
    else
        echo "Passwords do not match. Try again."
    fi
done

# -- Get user password --
while true; do
    read -s -p "Enter $USERNAME password:" USER_PASS
    echo
    if [ -z "$USER_PASS" ]; then
        echo "Password cannot be empty. Try again."
        continue
    fi
    read -s -p "Confirm $USERNAME password:" USER_PASS_CONFIRM
    echo
    if [ "$USER_PASS" == "$USER_PASS_CONFIRM" ]; then
        break
    else
        echo "Passwords do not match. Try again."
    fi
done

# -- Update system clock -- 
echo "Updating system clock..."
timedatectl set-ntp true

# -- Run disk script --
bash install/disk.sh

# -- Install essential packages --
echo "Installing essential packages with pacstrap..."
pacstrap /mnt $CPU_UCODE base dhcpcd linux linux-firmware git neovim sudo

# -- Generate an fstab file --
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# -- Run chroot script --
cp -r install /mnt/
arch-chroot /mnt /install/chroot.sh "$ROOT_PASS" "$USER_PASS"

# -- Clean up the script --
echo "Unmounting /mnt..."
umount -R /mnt

echo "Done. You can now type 'reboot' to restart into your new system."

