#!/bin/bash

API_URL="https://api.frankfurter.app/latest?from=CAD&to=USD"
DATA_FILE="data/taux.json"
OUTPUT_FILE="output/rapport.txt"

echo "Récupération du taux de change CAD → USD..."

# Récupération avec suivi des redirections
curl -s -L "$API_URL" -o "$DATA_FILE"

# Vérification que le fichier n'est pas vide
if [ ! -s "$DATA_FILE" ]; then
    echo "ERREUR : impossible de récupérer les données de l'API."
    exit 1
fi

python3 scripts/analyse.py "$DATA_FILE" "$OUTPUT_FILE"

echo "Rapport généré dans $OUTPUT_FILE"
