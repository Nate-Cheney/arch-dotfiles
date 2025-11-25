#!/bin/bash

# Author: Nate Cheney
# Filename: chroot.sh 
# Description: This script executes all chroot commands for the new Arch Linux environment 
# Usage: Called from main.sh via arch-chroot
# Options:
#

set -e
set -o pipefail

# Load configuration
source /root/chroot_config.sh

echo "Starting configuration"

# Set time zone
echo "Setting timezone to $TIMEZONE..."
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# Set the locale
echo "Setting locale to $LOCALE..."
sed -i "s/#${LOCALE} UTF-8/${LOCALE} UTF-8/" /etc/locale.gen
locale-gen
echo "LANG=${LOCALE}" > /etc/locale.conf

# Network configuration
echo "Configuring network (hostname: $HOSTNAME)..."
echo "$HOSTNAME" > /etc/hostname
cat << EOF_HOSTS > /etc/hosts
127.0.0.1  localhost
::1        localhost
127.0.1.1  ${HOSTNAME}.localdomain ${HOSTNAME}
EOF_HOSTS

# Enable dhcpd and iwd
systemctl enable dhcpcd.service
systemctl enable iwd.service

# Set up DNS
cat <<EOF >> /etc/resolv.conf.head
nameserver 1.1.1.1
nameserver 1.0.0.1
EOF

# Configure mkinitcpio
echo "Configuring mkinitcpio hooks..."
sed -i 's/^HOOKS=(.*)/HOOKS=(base udev autodetect modconf block keyboard encrypt filesystems fsck)/' /etc/mkinitcpio.conf

# Generate the initramfs
echo "Generating initramfs..."
mkinitcpio -P

# Set the root password
echo "Setting root password..."
echo "root:${ROOT_PASS}" | chpasswd

# Create user 
echo "Creating user $USERNAME..."
useradd -m -G wheel -s /bin/bash "$USERNAME"

# Set the user's password
echo "$USERNAME:${USER_PASS}" | chpasswd

# Uncomment the wheel group in sudoers to allow sudo access
echo "Configuring sudo..."
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Configure the Boot Loader with systemd-boot
echo "Configuring systemd-boot..."
bootctl install

# Create loader.conf
cat << 'EOF_LOADER' > /boot/loader/loader.conf
default      arch.conf
timeout      3
console-mode max
editor       no
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

# Create Dev dir
dev_dir="/home/$USERNAME/Dev"
mkdir -p $dev_dir 
chown $USERNAME:$USERNAME "$dev_dir"

# Clone dotfiles repo
git clone --depth 1 https://github.com/Nate-Cheney/arch-dotfiles.git "$dev_dir/arch-dotfiles"
chown -R $USERNAME:$USERNAME "$dev_dir/arch-dotfiles"

echo "Chroot phase complete."

