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
    read -s -p "Enter root password: " ROOT_PASS
    echo
    if [ -z "$ROOT_PASS" ]; then
        echo "Password cannot be empty. Try again."
        continue
    fi
    read -s -p "Confirm root password: " ROOT_PASS_CONFIRM
    echo
    if [ "$ROOT_PASS" == "$ROOT_PASS_CONFIRM" ]; then
        break
    else
        echo "Passwords do not match. Try again."
    fi
done

# -- Get user password --
while true; do
    read -s -p "Enter $USERNAME password: " USER_PASS
    echo
    if [ -z "$USER_PASS" ]; then
        echo "Password cannot be empty. Try again."
        continue
    fi
    read -s -p "Confirm $USERNAME password: " USER_PASS_CONFIRM
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

# -- Get the UUID for bootloader config --
ROOT_PART_UUID=$(blkid -s UUID -o value $ROOT_PART)

# -- Create config file for chroot script --
cat > /mnt/root/chroot_config.sh << EOF
TIMEZONE="$TIMEZONE"
LOCALE="$LOCALE"
HOSTNAME="$HOSTNAME"
USERNAME="$USERNAME"
CPU_UCODE="$CPU_UCODE"
ROOT_PART_UUID="$ROOT_PART_UUID"
ROOT_PASS="$ROOT_PASS"
USER_PASS="$USER_PASS"
EOF

# -- Copy chroot script --
cp install/chroot.sh /mnt/root/

# -- Run chroot script --
arch-chroot /mnt /root/chroot.sh

# -- Clean up sensitive data --
rm -f /mnt/root/chroot_config.sh
rm -f /mnt/root/chroot.sh

# -- Unmount --
echo "Unmounting /mnt..."
umount -R /mnt

echo "Done. You can now type 'reboot' to restart into new system."

