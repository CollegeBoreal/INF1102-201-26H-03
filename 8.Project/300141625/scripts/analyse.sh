#!/bin/bash
# Script principal de monitoring

SITE="https://www.google.com"
OUTPUT="../output/rapport.txt"
LOG="../data/sample.log"

echo "Rapport de monitoring - $(date '+%Y-%m-%d')" > $OUTPUT
echo "-----------------------------------" >> $OUTPUT
echo "Site surveillé : $SITE" >> $OUTPUT

# Appeler Python pour analyser
python3 ../scripts/analyse.py $LOG $OUTPUT

echo "✅ Rapport généré : $OUTPUT"
