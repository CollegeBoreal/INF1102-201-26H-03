#!/bin/bash

echo "🚀 Démarrage du monitoring..."

# Créer le dossier output si nécessaire
mkdir -p output

# Exécuter le script Python
python3 scripts/analyse.py

echo "✅ Monitoring terminé !"
