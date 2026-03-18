#!/bin/bash

PIPE="/tmp/run/cuckoo.pid"
RESP="/tmp/run/cuckoo.resp"
LOGFILE="$HOME/cuckoo.log"

mkdir -p /tmp/run

if [ ! -p "$PIPE" ]; then
    mkfifo "$PIPE"
fi

if [ ! -p "$RESP" ]; then
    mkfifo "$RESP"
fi

trap 'echo "$(date "+%F %T") Shutdown!" >> "$LOGFILE"; rm -f "$PIPE" "$RESP"; exit 0' TERM

echo "$(date "+%F %T") Startup!" >> "$LOGFILE"

while true; do
    if read line < "$PIPE"; then
        n=$((RANDOM % 9 + 2))
        echo "$(date "+%F %T") $line $n" >> "$LOGFILE"
        echo "$n" > "$RESP"
    fi
done
