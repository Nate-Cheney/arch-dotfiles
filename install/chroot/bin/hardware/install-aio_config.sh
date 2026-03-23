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
# Usage: Ran by `install/chroot/hardware.sh` during the install process. 
# Options:
#

# Load configuration
if [ -f "/root/chroot_config.sh" ]; then
    source /root/chroot_config.sh
    su -p - $USERNAME
else
    echo -e "Not in CHROOT environment. \nUsing $USER to install packages and create the aio-control service..."
    USERNAME=$USER
    sudo -v
fi

package="liquidctl"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

# Ensure that there is an AIO Liquid Cooler installed
DEVICE_LIST=$(liquidctl list)
if [ -z "$DEVICE_LIST" ]; then
    echo "No AIO detected."
    echo "Removing $package..."
    sudo pacman -Rns --noconfirm $package
    echo "$package removed."
    return
fi

echo "Creating aio-control.service..."
cat <<EOF | sudo tee "/etc/systemd/system/aio-control.service" > /dev/null
[Unit]
Description=AIO Water Cooler Config

[Service]
User=root
ExecStart=/home/$USERNAME/.local/bin/aio-control.sh

[Install]
WantedBy=multi-user.target
EOF

echo "Done."

