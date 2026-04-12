#!/bin/bash
# Script principal de monitoring

SITE="https://www.google.com"
OUTPUT="output/rapport.txt"

echo "🚀 Démarrage du monitoring..."
echo "Site surveillé : $SITE"

python3 scripts/analyse.py data/sample.log $OUTPUT

echo "✅ Rapport généré : $OUTPUT"
cat $OUTPUT
