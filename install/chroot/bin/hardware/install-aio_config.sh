#!/bin/bash

# Author: Nate Cheney
# Filename: install-aio_config.sh 
# Description: 
#   This script ensures that liquidctl is installed 
#   and creates a systemd service that runs aio-control.sh
#
#   aio-control.sh sets:
#   50% AIO pump speed below 40
#   80% AIO pump speed above 40
#
# Usage: 
# Options:
#

# Ensure that there is an AIO Liquid Cooler installed
DEVICE_LIST=$(liquidctl list)
if [ -z "$DEVICE_LIST" ]; then
    echo "No AIO detected (liquidctl list was empty)."
    return
fi

# Load configuration
source /root/chroot_config.sh

su -p - $USERNAME

package="liquidctl"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi


cat <<EOF | sudo sudo tee "/etc/systemd/system/aio-control.service" > /dev/null
[Unit]
Description=AIO Water Cooler Config

[Service]
User=root
ExecStart=/usr/$USERNAME/.local/bin/aio-control.sh
EOF

