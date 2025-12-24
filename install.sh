#!/bin/bash

# Author: Nate Cheney
# Filename: install.sh 
# Description: This is the main install script for my Arch Linux configuration.
# Usage: ./install.sh
# Options:
#


# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# -- Get prerequisite info
source "./install/pre/disk.sh"
source "./install/pre/locale.sh"
# TODO: 
source "./install/pre/timezone.sh"
source "./install/pre/ucode.sh"

# -- chroot


# -- install packages


# -- configure gui


# -- final wrap-u
