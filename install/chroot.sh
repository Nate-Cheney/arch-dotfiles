#!/bin/bash

# Author: Nate Cheney
# Filename: chroot.sh 
# Description: This script executes all chroot commands for the new Arch Linux environment 
# Usage: ./chroot.sh
# Options:
#

source install/config.sh

set -e
set -o pipefail

# Read the passwords passed from main.sh
ROOT_PASS="$1"
USER_PASS="$2"

# Get the UUID of the LUKS partition for the bootloader
ROOT_PART_UUID=$(blkid -s UUID -o value $ROOT_PART)

# --- Pass variables from outer script ---
TIMEZONE="$TIMEZONE"
LOCALE="$LOCALE"
HOSTNAME="$HOSTNAME"
CPU_UCODE="$CPU_UCODE"
ROOT_PART_UUID="$ROOT_PART_UUID"
ROOT_PASS="$ROOT_PASS"

echo "Starting configuration"

# Set time zone
echo "Setting timezone to $TIMEZONE..."
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# Set the locale
echo "Setting locale to $LOCALE..."
sed -i "s/#\$LOCALE UTF-8/\$LOCALE UTF-8/" /etc/locale.gen
locale-gen
echo "LANG=\$LOCALE" > /etc/locale.conf

# Network configuration
echo "[Step 11] Configuring network (hostname: $HOSTNAME)..."
echo "\$HOSTNAME" > /etc/hostname
cat << EOF_HOSTS > /etc/hosts
127.0.0.1  localhost
::1        localhost
127.0.1.1  \$HOSTNAME.localdomain \$HOSTNAME
EOF_HOSTS

# Configure mkinitcpio
# Use sed to replace the default HOOKS line with the one required for encryption
echo "Configuring mkinitcpio hooks..."
sed -i 's/^HOOKS=(.*)/HOOKS=(base udev autodetect modconf block keyboard encrypt filesystems fsck)/' /etc/mkinitcpio.conf

# Generate the initramfs
echo "Generating initramfs..."
mkinitcpio -P

# Set the root password
echo "Setting root password..."
# Use chpasswd to set password non-interactively
echo "root:\$ROOT_PASS" | chpasswd

# Create user 
echo "Creating user $USERNAME..."
useradd -m -G wheel -s /bin/bash "$USERNAME"

# Set the user's password
echo "$USERNAME:$USER_PASS" | chpasswd

# Uncomment the wheel group in sudoers to allow sudo access
echo "Configuring sudo..."
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Configure the Boot Loader with systemd-boot
echo "Configuring systemd-boot..."
bootctl install

# Create loader.conf
cat << EOF_LOADER > /boot/loader/loader.conf
default      arch.conf
timeout      3
console-mode max
editor       no
EOF_LOADER

# Create arch.conf
cat << EOF_ARCH_CONF > /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /\$CPU_UCODE.img
initrd  /initramfs-linux.img
options cryptdevice=UUID=\$ROOT_PART_UUID:cryptroot root=/dev/mapper/cryptroot rw
EOF_ARCH_CONF

bootctl list

echo "Chroot phase complete. Exiting chroot."
exit

