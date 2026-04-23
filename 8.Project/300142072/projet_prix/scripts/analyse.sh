#!/bin/bash
# =============================================================
# analyse.sh — Script principal : Suivi de prix e-commerce
# Appelle le script Python et génère output/rapport.txt
# =============================================================

# Couleurs pour l'affichage
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   Suivi de prix — books.toscrape.com  ${NC}"
echo -e "${GREEN}========================================${NC}"

# Répertoire racine du projet (parent de scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Vérification des dossiers
mkdir -p "$ROOT_DIR/output"
mkdir -p "$ROOT_DIR/data"

echo -e "\n${YELLOW}[1/3] Vérification des dépendances Python...${NC}"

# Vérifie que Python 3 est installé
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}ERREUR : Python 3 n'est pas installé.${NC}"
    exit 1
fi

# Installe les librairies si nécessaire
pip3 install -r "$SCRIPT_DIR/requirements.txt" -q
echo -e "  ✔ Dépendances OK"

echo -e "\n${YELLOW}[2/3] Lancement du scraping et de l'analyse...${NC}"

# Appel du script Python
python3 "$SCRIPT_DIR/analyse.py" "$ROOT_DIR"

# Vérifie que le rapport a bien été généré
if [ -f "$ROOT_DIR/output/rapport.txt" ]; then
    echo -e "\n${YELLOW}[3/3] Rapport généré avec succès !${NC}"
    echo -e "${GREEN}------ Aperçu du rapport ------${NC}"
    cat "$ROOT_DIR/output/rapport.txt"
    echo -e "${GREEN}-------------------------------${NC}"
    echo -e "\n✔ Fichier complet : $ROOT_DIR/output/rapport.txt"
    echo -e "✔ Graphique       : $ROOT_DIR/output/evolution_prix.png"
    echo -e "✔ Données CSV     : $ROOT_DIR/data/prix_historique.csv"
else
    echo -e "${RED}ERREUR : Le rapport n'a pas été généré.${NC}"
    exit 1
fi

echo -e "\n${GREEN}Terminé ! Ouvre RAPPORT.ipynb pour la visualisation complète.${NC}"
