#!/bin/bash
# =============================================================
# Etudiant  : Babatunde Adissa Fadolle Arouna | 300151970
# Hiver     : 2026
# Programme : Techniques des systemes informatiques
# Cours     : INF 1102-201 Programmation de systemes
# Professeur: Brice Robert
# -------------------------------------------------------------
# FICHIER    : scripts/analyse.sh
# DESCRIPTION: Script Bash principal - verifie les fichiers
#              et appelle analyse.py pour les graphiques
# TERMINAL   : VM Ubuntu via SSH
# COMMANDE   : bash scripts/analyse.sh
# =============================================================

# --- Definition des chemins ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
JSON_FILE="$ROOT_DIR/data/meteo_raw.json"
OUTPUT_DIR="$ROOT_DIR/output"
RAPPORT="$OUTPUT_DIR/rapport.txt"
PYTHON_SCRIPT="$SCRIPT_DIR/analyse.py"

echo "============================================="
echo " Suivi Meteo - Toronto, Montreal, Vancouver"
echo " INF 1102-201 | Babatunde Arouna | 300151970"
echo "============================================="

# --- ETAPE 1 : Verification du fichier JSON ---
echo ""
echo "[1/4] Verification du fichier JSON..."
if [ ! -f "$JSON_FILE" ]; then
    echo "      ERREUR : fichier introuvable : $JSON_FILE"
    echo "      Veuillez d abord executer analyse.ps1 sur PowerShell"
    exit 1
fi
echo "      Fichier trouve : $JSON_FILE"

# --- ETAPE 2 : Creation du dossier output ---
echo ""
echo "[2/4] Creation du dossier output..."
mkdir -p "$OUTPUT_DIR"
echo "      Dossier pret : $OUTPUT_DIR"

# --- ETAPE 3 : Statistiques rapides avec Bash ---
echo ""
echo "[3/4] Verification Python et dependances..."
python3 --version
pip3 install -r "$SCRIPT_DIR/requirements.txt" --quiet
echo "      Dependances installees."

# --- ETAPE 4 : Lancement de l analyse Python ---
echo ""
echo "[4/4] Lancement de l analyse Python..."
python3 "$PYTHON_SCRIPT" "$JSON_FILE" "$RAPPORT"

echo ""
echo "============================================="
echo " Termine !"
echo " Rapport    : $RAPPORT"
echo " Graphiques : $OUTPUT_DIR"
echo "============================================="
