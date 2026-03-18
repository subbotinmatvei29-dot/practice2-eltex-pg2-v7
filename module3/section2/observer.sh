#!/bin/bash

CONFIG="$HOME/observer.conf"
LOGFILE="$HOME/observer.log"

while read task; do
    [ -z "$task" ] && continue

    found=0

    for procdir in /proc/[0-9]*; do
        [ -f "$procdir/comm" ] || continue

        procname=$(cat "$procdir/comm" 2>/dev/null)

        if [ "$procname" = "$task" ]; then
            found=1
            break
        fi
    done

    if [ "$found" -eq 0 ]; then
        nohup "$HOME/$task" >/dev/null 2>&1 &
        echo "$(date '+%F %T') restarted $task" >> "$LOGFILE"
    fi

done < "$CONFIG"
