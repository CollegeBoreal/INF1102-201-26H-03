#!/bin/bash

# Fichier des logs
LOG_FILE="/var/log/nginx/access.log"

# Fichier de sortie
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"

# Extraire les IP uniques et les stocker
awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE

# Optionnel : ajouter un timestamp à chaque exécution
echo "Script exécuté le $(date)" >> /home/ubuntu/nginx_ips.log
