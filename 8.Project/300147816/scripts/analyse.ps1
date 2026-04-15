#!/bin/bash

# Configuration
CITY="Montreal"
TOKEN="15021a914a52a8cad461e6c678f2895c3325a7d6" 
DATA_FILE="data/air_quality.json"

# Création du dossier data s'il n'existe pas
mkdir -p data

# 1. Récupération des données via API
echo "Récupération des données pour $CITY..."
curl -s "https://api.waqi.info/feed/$CITY/?token=$TOKEN" -o "$DATA_FILE"

# 2. Vérification et lancement de l'analyse
if [ -f "$DATA_FILE" ]; then
    echo "Succès ! Données enregistrées. Lancement de l'analyse..."
    # On lance Python SANS argument maintenant
    python3 scripts/analyse.py
else
    echo "Erreur lors de la récupération des données."
fi
