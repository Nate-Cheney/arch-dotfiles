#!/bin/bash

# Author: Nate Cheney
# Filename: configure-gui.sh 
# Description: This script configures SDDM and UWSM. 
# Usage: ./configure-gui.sh
# Options:
#

sudo -v

session_path="/usr/share/wayland-sessions"
session_file="hyprland-uwsm.desktop"

if [ ! -d $session_path ]; then
    mkdir -p "$session_path"
fi

if [ ! -f "$session_path/$session_file" ]; then
    touch "$session_path/$session_file"
fi
    
if ! grep -q "Name=Hyprland (uwsm-managed)" "$session_path/$session_file"; then
    cat <<EOF | sudo tee -a "$session_path/$session_file" > /dev/null
[Desktop Entry]
Name=Hyprland (uwsm-managed)
Comment=A UWSM-managed Hyprland session
TryExec=uwsm
Exec=uwsm start -- hyprland.desktop
DesktopNames=Hyprland
Type=Application
EOF
fi

