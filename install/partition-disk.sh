#!/bin/bash

# Author: Nate Cheney
# Filename: partition-disk.sh
# Description: This script partitions the disk. 
# Usage: ./partition-disk.sh
# Options:
#

source ./config.sh

# Prompt to continue
echo "This script will partition and format $DISK."
echo "All data will be lost."
read -p "Press Enter to continue or Ctrl-C to cancel.\n"

# Get LUKS passphrase
while true; do
    read -s -p "Enter LUKS passphrase:\n" LUKS_PASS
    read -s -p "Confirm LUKS passphrase:\n" LUKS_PASS_CONFIRM
    if [ "$LUKS_PASS" == "$LUKS_PASS_CONFIRM" ]; then
        break
    else
        echo "Passphrases do not match. Please try again."
    fi
done

# Partition disk
# g: create a new empty GPT partition table
# n: add a new partition (p=primary, 1=first partition, default first sector, +1G size)
# t: change partition type (ef = EFI System)
# n: add a new partition (p=primary, 2=second, default first/last sectors)
# t: change partition type (2=second partition, 83=Linux Filesystem)
# w: write changes and exit
echo "Partitioning $DISK..."
fdisk $DISK <<EOF
g
n
p
1

+1G
t
ef
n
p
2


w
EOF
echo "OK"
sleep 2

# Prepare the encrypted root partition
echo "Setting up encrypted root on $ROOT_PART..."
echo -n "$LUKS_PASS" | cryptsetup luksFormat $ROOT_PART -d -
echo -n "$LUKS_PASS" | cryptsetup open $ROOT_PART cryptroot -d -
mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt
echo "OK"

# Prepare the boot partition
echo "Setting up encrypted boot partition on $BOOT_PART..."
mkfs.fat -F32 $BOOT_PART
mkdir /mnt/boot
mount $BOOT_PART /mnt/boot
echo "OK"

