!#/bin/bash

# Author: Nate Cheney
# Filename: install.sh 
# Description: This is the main install script for my Arch Linux configuration.
# Usage: ./install.sh
# Options:
#

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Get ucode package
vendor=$(lscpu | awk '/Vendor ID/ {print $3}')
if (vendor == "AuthenticAMD"); then
    cpu_ucode="amd-ucode"
else
    cpu_ucode="intel-ucode"
fi

# TODO: get/verify the following info
# DISK="/dev/nvme0n1"
# ROOT_PART="${DISK}p2"
# BOOT_PART="${DISK}p1"
# TIMEZONE="America/Detroit"
# LOCALE="en_US.UTF-8"
