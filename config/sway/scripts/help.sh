#!/usr/bin/env sh

set -x

VISIBILITY_SIGNAL=30
QUIT_SIGNAL=31

RUNNING_PIDS=$(pgrep 'nwg-wrapper')

if [ ! -z "${RUNNING_PIDS}" ]; then
   kill $RUNNING_PIDS
else
    for output in $(swaymsg -t get_outputs --raw | jq -r '.[].name'); do
        nwg-wrapper -o "$output" -sv ${VISIBILITY_SIGNAL} -sq ${QUIT_SIGNAL} -s help.sh -p left -a start -mt 20 -ml 20 -l 3 -c $PWD/help.css &
    done
fi
