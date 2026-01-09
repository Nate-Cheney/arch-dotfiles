#!/bin/bash

# Author: Nate Cheney
# Filename: boot.sh 
# Description: This script configures everything for the system to boot. 
# Usage: Called from main.sh within the arch-chroot environment
# Options:
#

# Load configuration
source /root/chroot_config.sh

# Configure mkinitcpio
echo "Configuring mkinitcpio hooks..."
sed -i 's/^HOOKS=(.*)/HOOKS=(base udev autodetect modconf block keyboard encrypt filesystems fsck)/' /etc/mkinitcpio.conf

# Generate the initramfs
echo "Generating initramfs..."
mkinitcpio -P

# Configure the boot loader 
echo "Configuring systemd-boot..."
bootctl install

# Create loader.conf
cat << 'EOF_LOADER' > /boot/loader/loader.conf
default      arch.conf
timeout      3
console-mode max
editor       yes
EOF_LOADER

# Create arch.conf
cat > /boot/loader/entries/arch.conf << EOF_ARCH_CONF
title   Arch Linux
linux   /vmlinuz-linux
initrd  /${CPU_UCODE}.img
initrd  /initramfs-linux.img
options cryptdevice=UUID=${ROOT_PART_UUID}:cryptroot root=/dev/mapper/cryptroot rw
EOF_ARCH_CONF

echo "Boot configuration:"
bootctl list

