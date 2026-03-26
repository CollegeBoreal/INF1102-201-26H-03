#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="/root/nginx_ips.txt"
LOG_RUN="/root/nginx_ips.log"

awk '{print $1}' "$LOG_FILE" | sort | uniq > "$OUTPUT_FILE"
echo "Script exécuté le $(date)" >> "$LOG_RUN"