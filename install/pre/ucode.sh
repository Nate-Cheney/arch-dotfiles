#!/bin/bash

# Author: Nate Cheney
# Filename: ucode.sh 
# Description: Prerequisite script that gets the ucode package name.
# Usage: ./ucode.sh
# Options:
#

vendor=$(lscpu | awk '/Vendor ID/ {print $3}')
if ("$vendor" == "AuthenticAMD"); then
    CPU_UCODE="amd-ucode"
else
    CPU_UCODE="intel-ucode"
fi
export $CPU_UCODE
