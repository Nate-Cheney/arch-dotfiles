#!/bin/bash

# Author: Nate Cheney
# Filename: aio-control.sh
# Description: 
#   This script sets the AIO pump to:
#   50% speed below 40
#   80% speed at/above 40
# Usage: ./aio-control.sh
# Options:

sudo liquidctl initialize all
sudo liquidctl set pump speed 39 50 40 80

