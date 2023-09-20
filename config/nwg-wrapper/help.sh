#!/bin/sh
/usr/share/sway/scripts/sbdp.py "$HOME/.config/sway/modes/**" | jq --raw-output 'sort_by(.category) | .[] | .category + " / " + .action + ": <b>" + .keybinding + "</b>"' 
