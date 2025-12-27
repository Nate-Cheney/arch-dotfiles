#!/bin/bash

# Author: Nate Cheney
# Filename: packages.sh 
# Description: This script installs all packages for the system 
# Usage: Called from main.sh within the arch-chroot environment
# Options:
#

# Load configuration
source /root/chroot_config.sh

echo "Updating pacman manifest"
sudo pacman -Sy

# Switch to non-root user for yay 
su -p - $USERNAME
sudo -v

echo "Installing git"
bash "/root/chroot/bin/install-git.sh"

echo "Configuring git"
su - "$USERNAME" -c "bash /root/chroot/bin/configure-git.sh"

echo "Running yay installer" 
su - "$USERNAME" -c "bash /root/chroot/bin/install-yay.sh"

echo "Installing rsync"
bash "/root/chroot/bin/install-rsync.sh"

for file in /root/chroot/bin/install-*.sh; do
    if [[ "$file" == *"install-git.sh" ]] || [[ "$file" == *"install-yay.sh" ]] || [[ "$file" == *"install-rsync.sh" ]]; then
        continue
    fi

    if [ -f "$file" ]; then
        echo "Running: $file"
        if grep -q "yay -S" "$file"; then
            su - "$USERNAME" -c "bash $file"
        else
            bash "$file"
        fi
    fi
done
echo "Package installation complete."

