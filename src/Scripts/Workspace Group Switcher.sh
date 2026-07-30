#!/usr/bin/env bash

# The first argument passed to this script
# The group to switch to
GROUP="${1:?Usage: $0 <group>}"


# Get a JSON list of all connected monitors
MONITOR_INFO=$(hyprctl monitors -j)

mapfile -t MONITORS < <(
    echo "$MONITOR_INFO" |
    jq -r 'sort_by(.x) | .[].name'
)

MONITOR_COUNT=${#MONITORS[@]}


# Calculate the first workspace for this group
BASE=$(( (GROUP - 1) * MONITOR_COUNT + 1 ))


# Save the monitor that has focus so we can switch back to it later
CURRENT_MONITOR=$(
    echo "$MONITOR_INFO" |
    jq -r '.[] | select(.focused == true) | .name'
)


# Build a batch of commands
COMMANDS=""

# Loop through monitors
for INDEX in "${!MONITORS[@]}"; do
    # The workspace number to switch this montior to
    WORKSPACE=$(( BASE + INDEX ))

    CURRENT_WORKSPACE=$(
        echo "$MONITOR_INFO" |
        jq -r --arg MONITOR "${MONITORS[$INDEX]}" '.[] | select(.name == $MONITOR) | .activeWorkspace.id'
    )

    if [ "$CURRENT_WORKSPACE" != "$WORKSPACE" ]; then
        COMMANDS+="dispatch hl.dsp.focus({ monitor = \"${MONITORS[$INDEX]}\" });"
        COMMANDS+="dispatch hl.dsp.focus({ workspace = \"$WORKSPACE\" });"
    fi
done


# Run all workspace changes together
if [ -n "$COMMANDS" ]; then
    hyprctl --batch "$COMMANDS"
fi


# Refocus the saved monitor
hyprctl dispatch "hl.dsp.focus({ monitor = \"$CURRENT_MONITOR\" })"