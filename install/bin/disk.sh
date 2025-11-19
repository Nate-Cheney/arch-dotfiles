#!/bin/bash

# Author: Nate Cheney
# Filename: disk.sh
# Description: This script partitions the disk. 
# Usage: ./disk.sh
# Options:
#

set -e
set -o pipefail

source install/config.sh

# Prompt to continue
echo "=========================================="
echo "WARNING: This will destroy all data on $DISK"
echo "=========================================="
read -p "Press Enter to continue or Ctrl-C to cancel... "

# Get LUKS passphrase
while true; do
    read -s -p "Enter LUKS passphrase: " LUKS_PASS
    echo
    if [ -z "$LUKS_PASS" ]; then
        echo "Passphrase cannot be empty. Try again."
        continue
    fi
    read -s -p "Confirm LUKS passphrase: " LUKS_PASS_CONFIRM
    echo
    if [ "$LUKS_PASS" == "$LUKS_PASS_CONFIRM" ]; then
        break
    else
        echo "Passphrases do not match. Please try again."
    fi
done

# Partition disk
echo "Partitioning $DISK..."
(
echo g      # Create GPT partition table
echo n      # New partition
echo 1      # Partition number
echo        # Default first sector
echo +1G    # Size
echo t      # Change type
echo 1      # EFI System
echo n      # New partition
echo 2      # Partition number
echo        # Default first sector
echo        # Default last sector (use remaining space)
echo w      # Write changes
) | fdisk $DISK

# Wait for kernel to recognize changes
sleep 2
partprobe $DISK || true
sleep 2

# Verify partitions exist
if [ ! -b "$BOOT_PART" ]; then
    echo "Error: Boot partition $BOOT_PART not found!"
    exit 1
fi

if [ ! -b "$ROOT_PART" ]; then
    echo "Error: Root partition $ROOT_PART not found!"
    exit 1
fi

# Prepare the encrypted root partition
echo "Setting up encrypted root on $ROOT_PART..."
echo -n "$LUKS_PASS" | cryptsetup luksFormat --type luks2 $ROOT_PART -d - || {
    echo "Error: Failed to format LUKS partition"
    exit 1
}

echo -n "$LUKS_PASS" | cryptsetup open $ROOT_PART cryptroot -d - || {
    echo "Error: Failed to open LUKS partition"
    exit 1
}

echo "Formatting root partition..."
mkfs.ext4 -F /dev/mapper/cryptroot || {
    echo "Error: Failed to format root filesystem"
    cryptsetup close cryptroot
    exit 1
}

echo "Mounting root partition..."
mount /dev/mapper/cryptroot /mnt || {
    echo "Error: Failed to mount root"
    cryptsetup close cryptroot
    exit 1
}

# Prepare the boot partition
echo "Setting up boot partition on $BOOT_PART..."
mkfs.fat -F32 $BOOT_PART || {
    echo "Error: Failed to format boot partition"
    umount /mnt
    cryptsetup close cryptroot
    exit 1
}

mkdir -p /mnt/boot
mount $BOOT_PART /mnt/boot || {
    echo "Error: Failed to mount boot partition"
    umount /mnt
    cryptsetup close cryptroot
    exit 1
}

echo "Disk setup complete"
lsblk $DISK

