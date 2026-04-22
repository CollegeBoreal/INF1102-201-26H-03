#!/bin/bash

echo "Lancement de l'analyse du fichier log..."
python3 scripts/analyse.py

echo "Analyse terminée."
echo "Le rapport est disponible dans output/rapport.txt"
