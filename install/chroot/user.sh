#!/bin/bash

# Author: Nate Cheney
# Filename: user.sh 
# Description: This script configures everything related to the root and non-root user. 
# Usage: Called from main.sh within the arch-chroot environment
# Options:
#

# Load configuration
source /root/chroot_config.sh

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

# Create Dev dir
dev_dir="/home/$USERNAME/Dev"
mkdir -p $dev_dir 
chown $USERNAME:$USERNAME "$dev_dir"

# Clone dotfiles repo
git clone --depth 1 https://github.com/Nate-Cheney/arch-dotfiles.git "$dev_dir/arch-dotfiles"
chown -R $USERNAME:$USERNAME "$dev_dir/arch-dotfiles"

