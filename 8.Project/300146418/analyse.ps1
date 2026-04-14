#!/bin/bash

LOGFILE="data/sample.log"
OUTPUT="output/rapport.txt"

echo "Lancement de l'analyse..."
python3 scripts/analyse.py "$LOGFILE"

echo "Analyse terminée."
echo "Rapport disponible dans $OUTPUT"
