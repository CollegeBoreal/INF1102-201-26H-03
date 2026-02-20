#!/bin/bash

# Fichier des logs Nginx
LOG_FILE="/var/log/nginx/access.log"

# Fichier de sortie
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"

# Fichier log d'exécution
LOG_EXEC="/home/ubuntu/nginx_execution.log"

# Extraire les IP uniques
awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE

# Ajouter date d'exécution
echo "Script exécuté le $(date)" >> $LOG_EXEC
