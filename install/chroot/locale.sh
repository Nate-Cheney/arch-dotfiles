#!/bin/bash

# Author: Nate Cheney
# Filename: locale.sh 
# Description: This script sets the locale for the system. 
# Usage: Called from main.sh within the arch-chroot environment
# Options:
#

# Load configuration
source /root/chroot_config.sh

# Set the locale
echo "Setting locale to $LOCALE..."
sed -i "s/#${LOCALE} UTF-8/${LOCALE} UTF-8/" /etc/locale.gen
locale-gen
echo "LANG=${LOCALE}" > /etc/locale.conf

