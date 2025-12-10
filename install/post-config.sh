#!/bin/bash

# Author: Nate Cheney
# Filename: post-config.sh 
# Description: 
#   This script does the post install configuring of my system. 
#   It is 'step 2' after main.sh
# Usage: ./post-config.sh
# Options:
#

# -- Install packages
bash "install/bin/run-install-scripts.sh"

# -- Configure GUI
bash "install/bin/configure-gui.sh"

# -- Hide unecessary apps from launcher
bash "install/bin/hide-apps.sh"

