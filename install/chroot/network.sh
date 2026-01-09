#!/bin/bash

# Author: Nate Cheney
# Filename: network.sh 
# Description: This script configures the network stack for the system. 
# Usage: Called from main.sh within the arch-chroot environment
# Options:
#

# Load configuration
source /root/chroot_config.sh

echo "Configuring network..."

echo "$HOST_NAME" > /etc/hostname

cat << EOF_HOSTS > /etc/hosts
127.0.0.1  localhost
::1        localhost
127.0.1.1  ${HOST_NAME}.localdomain ${HOST_NAME}
EOF_HOSTS

cat << EOF_HOSTS > /etc/systemd/network/20-wired.network
[Match]
Name=en*

[Network]
DHCP=yes
EOF_HOSTS

cat << EOF_HOSTS > /etc/systemd/network/25-wireless.network
[Match]
Name=wl*

[Network]
DHCP=yes
IgnoreCarrierLoss=3s
EOF_HOSTS

cat <<EOF >> /etc/systemd/resolved.conf.d/dns_servers.conf
[Resolve]
DNS=1.1.1.1 1.0.0.1
Domains=~.
EOF

# Enable network stack via systemd
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
systemctl enable iwd.service

# Disable systemd-networkd wait service (causes time out issues)
systemctl disable systemd-networkd-wait-online.service

