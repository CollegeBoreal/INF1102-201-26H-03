#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="$HOME/nginx_ips.txt"
EXEC_LOG="$HOME/nginx_ips.log"

awk '{print $1}' "$LOG_FILE" | sort | uniq > "$OUTPUT_FILE"
echo "Script exécuté le $(date)" >> "$EXEC_LOG"