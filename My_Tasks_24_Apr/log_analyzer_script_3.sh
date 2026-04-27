# Task 3: Log Analyzer Script
# Given a log file, count:
# - ERROR
# - INFO
# Output format:
# ERROR: count
# INFO: count
# Bonus:
# - Show top 3 frequent error messages
# .............................................................................................................


#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File not found!"
    exit 1
fi

ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")
INFO_COUNT=$(grep -c "INFO" "$LOG_FILE")

echo "ERROR: $ERROR_COUNT"
echo "INFO: $INFO_COUNT"

echo ""
echo "Top 3 frequent ERROR messages:"

grep "ERROR" "$LOG_FILE" | sed 's/^.*ERROR[: ]*//' | sort | uniq -c | sort -nr | head -3
    
