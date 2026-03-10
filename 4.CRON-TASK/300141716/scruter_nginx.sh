#!/bin/bash

# fichier log nginx
LOG_FILE="/var/log/nginx/access.log"

# fichier sortie
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"

# extraire les IP uniques
awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE

# enregistrer execution
echo "Script exécuté le $(date)" >> /home/ubuntu/nginx_ips.log