#!/bin/bash

# Author: Nate Cheney
# Filename: install.sh 
# Description: This is the main install script for my Arch Linux configuration.
# Usage: ./install.sh
# Options:
#


# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# -- Pre-requisites 
source "./install/pre/disk.sh"
source "./install/pre/locale.sh"
source "./install/pre/luks.sh"
source "./install/pre/password.sh"
source "./install/pre/timezone.sh"
source "./install/pre/ucode.sh"

# -- Main
source "./install/main/main.sh"

