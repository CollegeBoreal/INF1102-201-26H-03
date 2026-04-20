#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"

awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE

echo "Script exécuté le $(date)" >> /home/ubuntu/nginx_ips.log
