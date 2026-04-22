#!/bin/bash

# ============================================
# Projet 5 - Monitoring de site web
# Script Bash : collecte des données HTTP
# ============================================

URL="https://www.google.com"
LOG_FILE="data/sample.log"
RAPPORT="output/rapport.txt"

echo "=== Monitoring démarré : $(date) ===" | tee -a "$LOG_FILE"

# Mesure le temps de réponse et le code HTTP
HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" --max-time 10 "$URL")
TEMPS=$(curl -o /dev/null -s -w "%{time_total}" --max-time 10 "$URL")

# Enregistre dans le log
echo "$(date '+%Y-%m-%d %H:%M:%S') | URL: $URL | CODE: $HTTP_CODE | TEMPS: ${TEMPS}s" >> "$LOG_FILE"

echo "Code HTTP : $HTTP_CODE"
echo "Temps de réponse : ${TEMPS}s"

# Appelle le script Python pour analyser
python3 scripts/analyse.py "$LOG_FILE" "$RAPPORT"
