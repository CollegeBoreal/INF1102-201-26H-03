#!/bin/bash

echo "Lancement de l'analyse du serveur Nginx..."
python3 scripts/analyse.py

if [ $? -eq 0 ]; then
    echo "Analyse terminée avec succès."
else
    echo "Erreur pendant l'analyse."
fi
