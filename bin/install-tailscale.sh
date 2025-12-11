#!/bin/bash

# Author: Nate Cheney
# Filename: install-tailscale.sh
# Description: 
#   This script installs and starts tailscale.
#   It also configugures a tailscale.network file for systemd-networkd and systemd-resolved.
# Usage: ./install-tailscale.sh
# Options:
#

package="tailscale"

if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

# Start the tailscaled service
sudo systemctl start tailscaled
sudo systemctl enable tailscaled

# If ts has not been authenticated or the key is expired, 
# it will wait here until someone manually follows the URL and authenticates 
sudo tailscale up --accept-routes

# Clear ts network config if it exists
tsNetFile="/etc/systemd/network/50-tailscale.network"
if [ -f  $tsNetFile ]; then
    sudo rm $tsNetFile  
fi

# Fetch Magic DNS domain name
mDNSDomain=$(tailscale status --json | jq -r ".MagicDNSSuffix")
    
# Add tailnet domain(s) to network file
sudo sh -c "cat << EOF_HOSTS > $tsNetFile 
[Match]
Name=tailscale0

[Network]
KeepConfiguration=yes
DNS=100.100.100.100
Domains=~ts.net $mDNSDomain 
EOF_HOSTS"

# Restart network services
sudo systemctl restart systemd-networkd
sudo systemctl restart systemd-resolved

