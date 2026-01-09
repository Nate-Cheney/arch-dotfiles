#!/bin/bash

# Author: Nate Cheney
# Filename: timezone.sh 
# Description: This script sets the timezone for the system. 
# Usage: Called from main.sh within the arch-chroot environment
# Options:
#

# Load configuration
source /root/chroot_config.sh

# Set time zone
echo "Setting timezone to $TIMEZONE..."
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

