#!/bin/bash

# Author: Nate Cheney
# Filename: main.sh
# Description: This is the main pre-chroot script that:
#   - Updates the time.
#   - Creates the boot and root partitions and encrypts the root.
#   - Installs necessary packages.
#   - Generates a Filesystem Table.
#   - Preps chroot.
#   - Executes chroot scripts.
#   - Cleans up.
# Usage: ./main.sh
# Options:
#

# -- Update system clock -- 
echo "Updating system clock..."
timedatectl set-ntp true

# -- Run disk script --
source "./install/main/disk.sh"

# -- Install essential packages --
echo "Installing packages with pacstrap..."
pacstrap /mnt $CPU_UCODE base dhcpcd linux linux-firmware iwd git sudo liquidctl

# -- Generate an fstab file --
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# -- Create chroot config and tailscale auth
source "./install/main/config.sh"
source "./install/main/tailscale.sh"

# -- Copy chroot scripts
cp -r ./install/chroot/ /mnt/root/

# -- Run chroot script --
arch-chroot /mnt /root/chroot/main.sh

# -- Clean up sensitive data --
rm -f /mnt/root/chroot_config.sh
rm -f /mnt/root/tailscale_auth.sh
rm -rf /mnt/root/chroot/

# -- Unmount --
echo "Unmounting /mnt..."
umount -R /mnt

echo -e "\nFinished installing! Type 'reboot' to reboot into the system"

