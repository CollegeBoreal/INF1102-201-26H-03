#!/bin/bash

LOGFILE="data/sample.log"
OUTPUT="output/rapport.txt"

echo "Lancement de l'analyse Boreal..."
python3 scripts/analyse.py "$LOGFILE"
echo "Rapport disponible dans $OUTPUT"
