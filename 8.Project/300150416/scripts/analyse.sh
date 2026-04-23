#!/bin/bash

echo "=================================================="
echo "   ANALYSEUR DE LOGS — DEMARRAGE"
echo "=================================================="
echo "Date : $(date)"
echo ""

echo "[1] Vérification de Python..."
if command -v python3 >/dev/null 2>&1; then
    echo "[OK] Python3 détecté"
else
    echo "[ERREUR] Python3 non installé"
    exit 1
fi

echo "[2] Vérification des dossiers..."
mkdir -p data output
echo "[OK] Dossiers prêts"

echo "[3] Vérification des dépendances..."
python3 -c "import matplotlib" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "[INFO] Installation matplotlib..."
    pip3 install matplotlib
fi

python3 -c "import wordcloud" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "[INFO] Installation wordcloud..."
    pip3 install wordcloud
fi

echo "[OK] Dépendances OK"

echo "[4] Lancement de l’analyse..."
echo ""

python3 scripts/analyse.py

if [ $? -ne 0 ]; then
    echo "[ERREUR] Problème dans le script Python"
    exit 1
fi

echo ""
echo "=================================================="
echo "   ANALYSE TERMINEE AVEC SUCCES"
echo "=================================================="

echo "Fichiers générés :"
echo " - output/rapport.txt"
echo " - output/top_ip.png"
echo " - output/top_urls.png"
echo " - output/http_codes.png"
echo " - output/histogram.png"
echo " - output/wordcloud.png"
echo ""
