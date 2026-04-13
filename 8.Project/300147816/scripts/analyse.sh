#!/bin/bash
# Script de récupération de la qualité de l'air
CITY="Montreal"
TOKEN="15021a914a52a8cad461e6c678f2895c3325a7d6" 
DATA_FILE="data/air_quality.json"

# Récupération des données en cours via API
curl -s "https://api.waqi.info/feed/$CITY/?token=$TOKEN" -o "$DATA_FILE"

# Lancement de l'analyse Python
python3 scripts/analyse.py "$DATA_FILE"

# Vérifier si le fichier a bien été créé avant de lancer Python
if [ -f "$DATA_FILE" ]; then
    echo "Succès ! Données enregistrées dans $DATA_FILE"
  #On lance l'analyse Python
    
    python3 scripts/analyse.py "$DATA_FILE"
else
    echo "Erreur lors de la récupération des données."
fi
