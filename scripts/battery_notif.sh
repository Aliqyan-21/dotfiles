#!/bin/bash

THRESHOLD=15
while true; do
    charge_percent=$(acpi | grep -P -o '[0-9]+(?=%)')
    if [ "$charge_percent" -le "$THRESHOLD" ]; then
        action=$(dunstify --action="ok,OK" --action="cancel,CANCEL" -u critical \
        -i /usr/share/icons/Adwaita/scalable/status/battery-level-0-symbolic.svg \
        "Low Battery" "Battery is at ${charge_percent}%!")
        
        case "$action" in
            "ok")
                echo "User acknowledged the low battery notification."
                ;;
            "cancel")
                echo "User dismissed the notification."
                ;;
            *)
                echo "No action taken."
                ;;
        esac
        
        sleep 300
    fi
    sleep 60
done
