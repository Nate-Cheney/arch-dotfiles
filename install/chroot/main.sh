#!/bin/bash

# Author: Nate Cheney
# Filename: main.sh 
# Description: This is the main chroot script. 
# Usage: 
# Options:
#

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

source "/root/chroot/timezone.sh"
source "/root/chroot/locale.sh"
source "/root/chroot/network.sh"
source "/root/chroot/boot.sh"
source "/root/chroot/user.sh"
source "/root/chroot/packages"

