#!/usr/bin/env bash

# Settings
HYPRSUNSET="hyprsunset"        # Change if your binary has a different name
TEMPERATURE=4000               # Default temperature when turning on
PID_FILE="/tmp/hyprsunset.pid" # File to store the PID

# Check if hyprsunset is already running
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
        # Kill hyprsunset if running
        kill -9 "$PID"
        rm -f "$PID_FILE"
        exit 0
    else
        # PID file exists but process is dead; clean up
        rm -f "$PID_FILE"
    fi
fi

# If not running, start it
$HYPRSUNSET --temperature "$TEMPERATURE" &
echo $! >"$PID_FILE" # Save the PID
