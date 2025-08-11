#!/usr/bin/env bash

# Process each new message
notmuch search --output=summary tag:new | while read -r line; do
    # Extract relevant parts (adjust based on your notmuch output format)
    from=$(echo "$line" | sed -E 's/.*\] ([^;]+);.*/\1/')

    # Extract subject (everything after "; ")
    subject=$(echo "$line" | sed -E 's/.*; (.*)/\1/')

    # Clean up any trailing tags like "(new unread)"
    subject=$(echo "$subject" | sed -E 's/\([^)]*\)$//' | xargs)

    # Send notification
    notify-send -t 5000 "New email from $from" "$subject"
done
