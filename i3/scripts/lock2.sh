#!/bin/bash

# Aesthetic variables from lock2.sh
alpha='dd'
background='#282a36'
selection='#44475a'
comment='#6272a4'

yellow='#f1fa8c'
orange='#ffb86c'
red='#ff5555'
magenta='#ff79c6'
blue='#6272a4'
cyan='#8be9fd'
green='50fa7b'

# Path to the custom image (1000x512)
custom_image="/home/aliqyanabid/.config/i3/scripts/rickandmorty.png"

# Take a screenshot of the current screen
scrot /tmp/screen.png

# Apply minimal blur using ImageMagick (keeping it very light to save time)
magick /tmp/screen.png -blur 0x2 /tmp/screen_blur.png

# Screen dimensions (only fetch once)
screen_width=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d'x' -f1)
screen_height=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d'x' -f2)

# Image dimensions
image_width=1000
image_height=512

# Calculate position to center the image
pos_x=$(( (screen_width - image_width) / 2 ))
pos_y=$(( (screen_height - image_height) / 2 ))

# Overlay the custom image on the blurred screenshot, centered
magick /tmp/screen_blur.png "$custom_image" -geometry +$pos_x+$pos_y -composite /tmp/screen_combined.png

# Lock the screen with the combined image and aesthetic settings (keyboard-only interaction)
i3lock -i /tmp/screen_combined.png \
  --insidever-color=$selection$alpha \
  --insidewrong-color=$selection$alpha \
  --inside-color=$selection$alpha \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ring-color=$blue$alpha \
  --line-uses-ring \
  --keyhl-color=$cyan$alpha \
  --bshl-color=$yellow$alpha \
  --separator-color=$selection$alpha \
  --verif-color=$green \
  --wrong-color=$red \
  --modif-color=$red \
  --layout-color=$blue \
  --date-color=$blue \
  --time-color=$blue \
  --screen 1 \
  --blur 1 \
  --noinput="No Input" \
  --lock-text="Locking..." \
  --lockfailed="Lock Failed" \
  --pass-media-keys \
  --pass-screen-keys \
  --pass-volume-keys \
  --time-font="JetBrainsMono Nerd Font" \
  --date-font="JetBrainsMono Nerd Font" \
  --layout-font="JetBrainsMono Nerd Font" \
  --verif-font="JetBrainsMono Nerd Font" \
  --wrong-font="JetBrainsMono Nerd Font" \
  --pointer=default  # Disable mouse input, allow keyboard input

# Clean up temporary files
rm /tmp/screen.png /tmp/screen_blur.png /tmp/screen_combined.png
