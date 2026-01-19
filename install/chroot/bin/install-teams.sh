#!/bin/bash

# Author: Nate Cheney
# Filename: install-teams.sh 
# Description: This script creates a Microsoft Teams web application using chromium.
# Usage: ./install-teams.sh
# Options:
#

cat << EOF > /usr/share/applications/teams.desktop 
[Desktop Entry]
Name=Microsoft Teams
Exec=chromium --new-window https://teams.cloud.microsoft/
Icon=/usr/share/icons/Papirus/48x48/apps/teams-for-linux.svg
Type=Application
Categories=Network;WebBrowser;
StartupWMClass=www.cloud.microsoft
EOF

