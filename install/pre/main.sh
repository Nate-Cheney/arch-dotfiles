#!/bin/bash

# Author: Nate Cheney
# Filename: main.sh 
# Description: This is the main script that executes all pre-requisite scripts. 
# Usage: 
# Options:
#

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Run all pre scripts
source "./install/pre/disk.sh"
source "./install/pre/locale.sh"
source "./install/pre/luks.sh"
source "./install/pre/name.sh"
source "./install/pre/password.sh"
source "./install/pre/timezone.sh"
source "./install/pre/ucode.sh"

