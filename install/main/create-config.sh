#!/bin/bash

# Author: Nate Cheney
# Filename: chroot.sh 
# Description: Creates `chroot_config.sh` to be sourced during the chroot process. 
#
# Usage: ./create-config.sh
# Options:
#

if [ -f "chroot-config.sh" ]; then
    rm -f chroot-config.sh
fi

cat > /mnt/root/chroot_config.sh << EOF
TIMEZONE="$TIMEZONE"
LOCALE="$LOCALE"
HOST_NAME="$HOST_NAME"
USERNAME="$USERNAME"
CPU_UCODE="$CPU_UCODE"
ROOT_PART_UUID="$ROOT_PART_UUID"
ROOT_PASS="$ROOT_PASS"
USER_PASS="$USER_PASS"
EOF

