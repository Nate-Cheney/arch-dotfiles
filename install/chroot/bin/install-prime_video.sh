#!/bin/bash

# Author: Nate Cheney
# Filename: install-prime_video.sh 
# Description: This script creates an Amazon Prime Video web application using chromium.
# Usage: ./install-prime_video.sh
# Options:
#

cat << EOF > /usr/share/applications/prime-video.desktop 
[Desktop Entry]
Name=Prime Video
Exec=chromium --app=https://www.amazon.com/gp/video/storefront
Icon=/usr/share/icons/Papirus/48x48/apps/amazon.svg
Type=Application
Categories=Network;WebBrowser;
StartupWMClass=www.amazon.com
EOF

