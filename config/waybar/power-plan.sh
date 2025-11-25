options="Performance\nBalanced\nPower Saver"

num_lines=$(echo -e "$options" | wc -l)

action=$(echo -e "$options" | walker --dmenu -Nn --height "$num_lines")

case $action in
    "Performance")
        powerprofilesctl set performance
        notify-send "Power Profile" "Switched to Performance"
    ;;

    "Balanced")
        powerprofilesctl set balanced
        notify-send "Power Profile" "Switched to Balanced"
    ;;

    "Power Saver")
        powerprofilesctl set power-saver
        notify-send "Power Profile" "Switched to power-saver"
    ;;

esac

