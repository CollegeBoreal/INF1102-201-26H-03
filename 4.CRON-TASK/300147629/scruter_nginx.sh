#!/bin/bash

# Fichier des logs (le bon fichier)
LOG_FILE="/var/log/nginx/mon_site_access.log"

# Fichier de sortie
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"

# Extraire les IP uniques en ignorant le proxy du Collège
grep -oP '^\d+\.\d+\.\d+\.\d+' "$LOG_FILE" \
| grep -v "10.250.0.30" \
| sort -u > "$OUTPUT_FILE"

# Ajouter un timestamp dans un fichier séparé
echo "Script exécuté le $(date)" >> /home/ubuntu/nginx_ips.log
