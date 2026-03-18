#!/bin/bash

SCRIPT_NAME="$(basename "$0")"
LOGFILE="report_${SCRIPT_NAME}.log"

if [ "$SCRIPT_NAME" = "template_task.sh" ]; then
    echo "я бригадир, сам не работаю"
    exit 0
fi

echo "$(date '+%F %T') [$$] Скрипт запущен" >> "$LOGFILE"

echo "${SCRIPT_NAME}[$$]: how much time do I have?" > /tmp/run/cuckoo.pid
read N < /tmp/run/cuckoo.resp

sleep "$N"

echo "$(date '+%F %T') [$$] Скрипт завершился, работал $N секунд." >> "$LOGFILE"
