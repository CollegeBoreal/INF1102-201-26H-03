#!/bin/bash

echo "Analyse en cours..."
python3 scripts/analyse.py
echo "Résultat :"
cat output/rapport.txt
