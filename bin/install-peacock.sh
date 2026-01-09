#!/bin/bash

# Author: Nate Cheney
# Filename: install-peacock.sh 
# Description: This script creates a Peacock web application using chromium.
# Usage: ./install-peacock.sh
# Options:
#

cat << EOF > /usr/share/applications/peacock.desktop 
[Desktop Entry]
Name=Peacock
Exec=chromium --app=https://www.amazon.com/gp/video/storefront
Icon=amazon
Type=Application
Categories=Network;WebBrowser;
StartupWMClass=www.amazon.com
EOF
