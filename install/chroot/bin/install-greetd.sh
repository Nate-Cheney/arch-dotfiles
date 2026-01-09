#!/bin/bash

# Author: Nate Cheney
# Filename: install-greetd.sh
# Description: This script installs and configures the greetd and ReGreet packages.
# Usage: ./install-greetd.sh
# Options:
#

sudo -v

# -- Install packages
package="greetd"
echo "Installing $package"
yay -S --noconfirm --needed \
       --answerdiff=None \
       --answerclean=None \
       --answeredit=None \
       "$package"


package="greetd-regreet cage"
if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

sudo mkdir -p "/etc/greetd"

cat <<EOF_GREETD | sudo sudo tee "/etc/greetd/config.toml" > /dev/null
[terminal]
# The VT to run the greeter on. Can be "next", "current" or a number
vt = 1

# Greeter
[default_session]
command = "cage -s -- regreet"
user = "greeter"

# Autologin
[initial_session]
command = "uwsm start -- hyprland.desktop"
user = "nate"
EOF_GREETD

cat <<EOF_REGREET | sudo sudo tee "/etc/greetd/regreet.toml" > /dev/null
[background]
path = "/usr/share/backgrounds/greeter.jpg"
fit = "Cover"

[GTK]
application_prefer_dark_theme = true
cursor_theme_name = "Adwaita"
font_name = "JetBrainsMono Nerd Font 18"
icon_theme_name = "Adwaita"
theme_name = "Adwaita"

[commands]
reboot = [ "systemctl", "reboot" ]
poweroff = [ "systemctl", "poweroff" ]

[widget.clock]
format = "%a %H:%M"
resolution = "500ms"
timezone = "America/Detroit"
label_width = 150
EOF_REGREET

cat <<EOF_HYPRCONF | sudo tee "/etc/greetd/hyprland.conf" > /dev/null
exec-once = regreet; hyprctl dispatch exit
misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
    disable_hyprland_guiutils_check = true
}
EOF_HYPRCONF

sudo systemctl enable greetd.service

