#!/bin/bash

# '31' - Red
# '32' - Green
# '33' - Yellow
# '34' - Blue
# '35' - Magenta
# '36' - Cyan
# '37' - White

# Display help message
show_help() {
    echo "Usage: $0 [density] [characters] [color code] [speed]"
    echo "  density     : Set the density of the raindrops (default 2)."
    echo "  characters  : Characters to use as raindrops (default '|')."
    echo "  color code  : ANSI color code for the raindrop (default 37 for white)."
    echo "  speed       : Choose speed from 1 (slowest) to 5 (fastest)."
    echo
    echo "Example: $0 5 '@' 32 3"
    read -p "Press any key to continue..." -n 1 -r  # Wait for user input to continue
    exit 0
}

# Function to clear the screen and hide the cursor
initialize_screen() {
    clear
    tput civis  # Hide cursor
    stty -echo  # Turn off key echo
    height=$(tput lines)
    width=$(tput cols)
}

# Declare an associative array to hold the active raindrops
declare -A raindrops

# Function to place raindrops based on density and characters
place_raindrop() {
    local chars=("$rain_char") # Quote to handle special characters
    for ((i=0; i<density; i++)); do
        for ch in "${chars[@]}"; do
            local x=$((RANDOM % width))
            local speed=$((RANDOM % speed_range + 1))
            raindrops["$x,0,$ch"]=$speed  # Store character with its speed at initial position
        done
    done
}

# Function to move raindrops
move_raindrops() {
    declare -A new_positions
    local buffer=""

    for pos in "${!raindrops[@]}"; do
        IFS=',' read -r x y ch <<< "$pos"
        local speed=${raindrops[$pos]}
        local newY=$((y + speed))
        buffer+="\e[${y};${x}H "

        if [ $newY -lt $height ]; then
            buffer+="\e[${newY};${x}H\e[${color}m${ch}\e[0m"
            new_positions["$x,$newY,$ch"]=$speed
        fi
    done

    raindrops=()
    for k in "${!new_positions[@]}"; do
        raindrops["$k"]=${new_positions["$k"]}
    done
    echo -ne "$buffer"
}

# Function to reset terminal settings on exit
cleanup() {
    tput cnorm
    stty echo
    clear
    exit 0
}

# Ensure cleanup is called on script exit or interrupt
trap cleanup SIGINT SIGTERM EXIT

# Check input parameters and display help if needed
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ -n "$1" ]] && (! [[ "$1" =~ ^[0-9]+$ ]] || ! [[ "$3" =~ ^[0-9]+$ ]] || ! [[ "$4" =~ ^[0-9]+$ ]]); then
    echo "Error: Please provide valid numerical input for density, color code, and speed, for more information use $0 -h"
    read
    exit 1
fi

# Initialize the screen and variables
initialize_screen
density=${1:-2}
rain_char=${2:-'|'}  # Treat input as separate characters for multiple raindrops
color=${3:-'37'}
speed_range=${4:-2}

# Main loop for the animation
while true; do
    read -s -n 1 -t 0.01 key
    if [[ $key == "q" ]]; then
        cleanup
    fi
    place_raindrop
    move_raindrops
    sleep 0.01
done
