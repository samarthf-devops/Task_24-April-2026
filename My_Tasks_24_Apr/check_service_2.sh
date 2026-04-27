# Task 2: Bash Script – Service Monitor
# Write a script: check_service.sh <service_name>
# Requirements:
# - Check if service is running
# - If NOT:
# - restart it
# - log action in /tmp/service_monitor.log
# - Print timestamp and status (RUNNING / RESTARTED / FAILED)
# Bonus:
# - Add retry (3 attempts)
# - Use proper exit codes
#...............................................................................................

#!/bin/bash

SERVICE="${1:-nginx}"
LOG_FILE="/tmp/service_monitor.log"
MAX_RETRIES=3

timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

log() {
    echo "$(timestamp) - $SERVICE - $1" | tee -a "$LOG_FILE"
}

is_running() {
    systemctl is-active --quiet "$SERVICE"
}

restart_service() {
    systemctl restart "$SERVICE"
}

# Check if running
if is_running; then
    log "RUNNING"
    exit 0
fi

# Retry loop
for ((i=1; i<=MAX_RETRIES; i++)); do
    log "Attempt $i to restart"

    restart_service
    sleep 2

    if is_running; then
        log "RESTARTED (attempt $i)"
        exit 0
    fi
done

# Failed
log "FAILED after $MAX_RETRIES attempts"
exit 2
