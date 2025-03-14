#!/bin/bash
THRESHOLD=15
CRITICAL_THRESHOLD=10
CHECK_INTERVAL=60
NOTIFICATION_ID=1234
SOUND_FILE="./beep.mp3"

# Function to notify user
notify_user() {
    charge_percent=$1
    urgency="critical"
    message="Battery is at ${charge_percent}%!"
    
    # Play sound based on battery level
    if [ "$charge_percent" -le "$CRITICAL_THRESHOLD" ]; then
        # Play sound for critical level (if paplay is available)
        if command -v paplay &>/dev/null; then
            paplay "$SOUND_FILE" &
        elif command -v aplay &>/dev/null; then
            aplay "$SOUND_FILE" &
        elif command -v mpg123 &>/dev/null; then
            mpg123 "$SOUND_FILE" &
        fi
    fi
    
    action=$(dunstify --replace="$NOTIFICATION_ID" --action="ok,OK" --action="cancel,CANCEL" -u "$urgency" \
        -i /usr/share/icons/Adwaita/scalable/status/battery-level-0-symbolic.svg \
        "Low Battery" "$message")
    echo "$action"
}

# Function to check if the laptop is charging
is_charging() {
    charging_status=$(acpi -a | grep -o 'on-line')
    if [ "$charging_status" == "on-line" ]; then
        return 0  # true
    else
        return 1  # false
    fi
}

# Check if sound file exists, otherwise use a fallback
if [ ! -f "$SOUND_FILE" ]; then
    # Try to find alternative sound files
    for sound_path in "/usr/share/sounds" "/usr/local/share/sounds"; do
        if [ -d "$sound_path" ]; then
            # Look for any sound file
            SOUND_FILE=$(find "$sound_path" -name "*.oga" -o -name "*.wav" -o -name "*.mp3" | head -n 1)
            if [ -n "$SOUND_FILE" ]; then
                break
            fi
        fi
    done
    
    # If no sound file found, use a default silent behavior
    if [ ! -f "$SOUND_FILE" ]; then
        echo "Warning: No sound file found. Sound alerts will be disabled."
    fi
fi

# Initialize notification state
notification_active=false
last_alert_time=0

while true; do
    charge_percent=$(acpi | grep -P -o '[0-9]+(?=%)')
    charging=$(is_charging && echo true || echo false)
    current_time=$(date +%s)
    
    # Check if notification should be shown or dismissed
    if [ "$charge_percent" -le "$THRESHOLD" ] && [ "$charging" == "false" ]; then
        # Battery low and not charging, show notification if not already shown
        if [ "$notification_active" == "false" ]; then
            action=$(notify_user "$charge_percent")
            notification_active=true
            last_alert_time=$current_time
            
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
        # Re-alert with sound if we're at critical level and it's been more than 5 minutes
        elif [ "$charge_percent" -le "$CRITICAL_THRESHOLD" ] && [ $((current_time - last_alert_time)) -ge 300 ]; then
            action=$(notify_user "$charge_percent")
            last_alert_time=$current_time
            echo "Re-alerting user about critical battery level."
        fi
        sleep 300  # Wait for 5 minutes before checking again
    else
        # Battery is above threshold or laptop is charging, dismiss notification if active
        if [ "$notification_active" == "true" ]; then
            dunstify --close="$NOTIFICATION_ID"
            echo "Notification dismissed as the battery is above threshold or laptop is now charging."
            notification_active=false
        fi
    fi
    
    sleep $CHECK_INTERVAL
done
