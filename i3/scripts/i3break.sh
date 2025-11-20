#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <minutes>"
    echo "Example: $0 15"
    exit 1
fi

MINUTES=$1

# Calculate the return time
RETURN_TIME=$(date -d "+${MINUTES} minutes" +"%I:%M %p")

# Get screen dimensions
screen_width=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d'x' -f1)
screen_height=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d'x' -f2)

# Create a blurred screenshot with nice text
scrot /tmp/screen.png

magick /tmp/screen.png -blur 0x8 \
    -gravity center \
    -pointsize 60 \
    -fill white \
    -stroke black \
    -strokewidth 3 \
    -annotate +0-100 "I am Away from desk" \
    -pointsize 90 \
    -fill "#8be9fd" \
    -stroke "#282a36" \
    -strokewidth 4 \
    -annotate +0+50 "Will be Back by ${RETURN_TIME}" \
    -pointsize 40 \
    -fill white \
    -stroke black \
    -strokewidth 2 \
    -annotate +0+150 "🔒" \
    /tmp/screen_text.png

# Lock with the image
i3lock -i /tmp/screen_text.png

# Clean up
rm /tmp/screen.png /tmp/screen_text.png
