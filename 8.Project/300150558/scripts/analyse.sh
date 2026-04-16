#!/bin/bash

echo "Installation des dépendances..."
pip3 install -r scripts/requirements.txt

echo "Lancement de l'analyse..."
python3 scripts/analyse.py
