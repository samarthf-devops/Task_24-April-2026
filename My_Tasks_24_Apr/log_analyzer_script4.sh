#!/bin/bash

# Check if log file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE="$1"

# Check if file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File not found!"
    exit 1
fi

# Count ERROR and INFO
ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")
INFO_COUNT=$(grep -c "INFO" "$LOG_FILE")

# Output format
echo "ERROR: $ERROR_COUNT"
echo "INFO: $INFO_COUNT"

echo ""
echo "Top 3 frequent ERROR messages:"

# Extract error messages and count frequency
grep "ERROR" "$LOG_FILE" \
    | sed 's/^.*ERROR[: ]*//' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -3
    
