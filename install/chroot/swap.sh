#!/bin/bash

# Author: Nate Cheney
# Filename: swap.sh 
# Description: 
#   This script 
#   and creates a systemd service that activates the swap. 
#
# Usage: Ran by `install/chroot/main.sh` during the install process. 
# Options:
#

SWAP_FILE="/swapfile"

# 1. Get the exact total RAM in Kilobytes directly from system info
MEM_KB=$(awk '/MemTotal/ {print $2}' /proc/meminfo)

# 2. Convert to Megabytes and add 2048 MB (2 GB)
MEM_MB=$((MEM_KB / 1024))
SWAP_MB=$((MEM_MB + 2048))

echo "Detected RAM: ${MEM_MB} MB"
echo "Creating a swap file of exactly: ${SWAP_MB} MB..."

mkswap -U clear --size "$SWAP_MB" --file "$SWAP_FILE"
swapon $SWAP_FILE

echo "Creating systemd service to activate the swap."
sudo tee /etc/systemd/system/swapfile.swap > /dev/null <<EOF
[Swap]
What=$SWAP_FILE

[Install]
WantedBy=swap.target
EOF

systemctl enable swapfile.swap

echo "Swap space created and enabled successfully."

