#!/bin/bash

SERVICE="${1:-nginx}"  
LOG_FILE="/tmp/service_monitor.log"
MAX_RETRIES=3

timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

is_running() {
    systemctl is-active --quiet "$SERVICE"
}

log() {
    echo "$(timestamp) - $SERVICE - $1" | tee -a "$LOG_FILE" #2026-04-24 14:10:01 - nginx - RUNNING... it means store the logs in the service_monitor.log
}

# Check if service is running
if is_running; then
    log "RUNNING"
    exit 0
fi

# Retry restart
for ((i=1; i<=MAX_RETRIES; i++)); do
    log "Attempt $i to restart"

    systemctl restart "$SERVICE"
    sleep 2

    if is_running; then
        log "RESTARTED (attempt $i)"
        exit 0
    fi
done

# If all retries fail
log "FAILED after $MAX_RETRIES attempts"
exit 2
