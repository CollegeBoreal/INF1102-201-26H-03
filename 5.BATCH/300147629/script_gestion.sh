#!/bin/bash

LOGFILE="/var/log/nginx/mon_site_access.log"
OUTPUT="/home/ubuntu/nginx_ips.txt"

if [ ! -f "$LOGFILE" ]; then
    echo "Fichier de logs introuvable : $LOGFILE"
    exit 1
fi

grep -oP '^\d+\.\d+\.\d+\.\d+' "$LOGFILE" \
| grep -v "10.250.0.30" \
| sort -u > "$OUTPUT"

echo "IP détectées et enregistrées dans $OUTPUT"
