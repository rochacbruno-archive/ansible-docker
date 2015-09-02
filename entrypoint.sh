#!/bin/bash
set -e

cd /app

WAIT_COMMAND=$(nc -zv mongo 27017)
WAIT_START_CMD=python manage.py runserver --host 0.0.0.0 --reloader --debug
WAIT_SLEEP=3
WAIT_LOOPS=50

is_ready() {
    eval "$WAIT_COMMAND"
}

# wait until is ready
i=0
while ! is_ready; do
    i=`expr $i + 1`
    if [ $i -ge $WAIT_LOOPS ]; then
        echo "$(date) - still not ready, giving up"
        exit 1
    fi
    echo "$(date) - waiting to be ready - $i"
    sleep $WAIT_SLEEP
done

#start the script
exec $WAIT_START_CMD
