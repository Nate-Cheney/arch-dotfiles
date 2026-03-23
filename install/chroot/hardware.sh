#!/bin/bash

# Author: Nate Cheney
# Filename: hardware.sh 
# Description: This script runs hardware specific install scripts. 
# Usage: Called from main.sh within the arch-chroot environment
# Options:
#

# Load configuration
source /root/chroot_config.sh

# Install discrete GPU drivers
if lspci -nn | grep -q "10de:"; then
    echo "NVIDIA GPU detected. Installing drivers..."
    bash "/root/chroot/bin/hardware/install-nvidia_gpu.sh"
elif lspci -nn | grep -q "8086:56\|8086:e2"; then
    echo "Intel Arc (Alchemist/Battlemage) GPU detected. Installing drivers..." 
    bash "/root/chroot/bin/hardware/install-nvidia_gpu.sh"
fi

# Instal AIO software
bash "/root/chroot/bin/hardware/install-aio_config.sh"

