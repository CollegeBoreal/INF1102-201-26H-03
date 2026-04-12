#!/bin/bash
# =============================================================================
# analyse.sh — Script Bash principal de suivi de prix e-commerce
# Auteur  : Projet 3
# Usage   : bash scripts/analyse.sh
# Planification (cron) : 0 9 * * * /bin/bash /chemin/vers/scripts/analyse.sh
# =============================================================================

# --------------------------------------------------------------------------
# 0. Configuration générale
# --------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

DATA_DIR="$PROJECT_DIR/data"
OUTPUT_DIR="$PROJECT_DIR/output"
LOG_FILE="$DATA_DIR/scraping.log"
CSV_FILE="$DATA_DIR/prices.csv"
RAPPORT_TXT="$OUTPUT_DIR/rapport.txt"
PYTHON_SCRIPT="$SCRIPT_DIR/analyse.py"
REQUIREMENTS="$SCRIPT_DIR/requirements.txt"

# Couleurs terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --------------------------------------------------------------------------
# 1. Fonctions utilitaires
# --------------------------------------------------------------------------

log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

print_banner() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════╗"
    echo "║       🛒  Suivi de Prix E-Commerce               ║"
    echo "║       Projet 3 — Bash + Python                   ║"
    echo "╚══════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

check_python() {
    if ! command -v python3 &>/dev/null; then
        log "ERROR" "Python3 introuvable. Veuillez l'installer."
        exit 1
    fi
    log "INFO" "Python3 détecté : $(python3 --version)"
}

install_dependencies() {
    log "INFO" "Vérification des dépendances Python..."
    if [ -f "$REQUIREMENTS" ]; then
        pip3 install -r "$REQUIREMENTS" --quiet 2>>"$LOG_FILE"
        if [ $? -eq 0 ]; then
            log "INFO" "Dépendances installées avec succès."
        else
            log "WARN" "Certaines dépendances n'ont pas pu être installées."
        fi
    else
        log "WARN" "Fichier requirements.txt introuvable."
    fi
}

create_directories() {
    for dir in "$DATA_DIR" "$OUTPUT_DIR"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            log "INFO" "Dossier créé : $dir"
        fi
    done
}

init_csv() {
    # Crée l'en-tête du CSV si le fichier n'existe pas encore
    if [ ! -f "$CSV_FILE" ]; then
        echo "date,heure,produit,prix,url" > "$CSV_FILE"
        log "INFO" "Fichier CSV initialisé : $CSV_FILE"
    fi
}

# --------------------------------------------------------------------------
# 2. Exécution principale
# --------------------------------------------------------------------------

main() {
    print_banner

    log "INFO" "=== Démarrage de l'analyse ==="

    # Vérifications préalables
    check_python
    create_directories
    install_dependencies
    init_csv

    # Lancement du script Python de scraping
    log "INFO" "Lancement du script Python : $PYTHON_SCRIPT"
    python3 "$PYTHON_SCRIPT" \
        --csv "$CSV_FILE" \
        --output "$RAPPORT_TXT" \
        --log "$LOG_FILE"

    PYTHON_EXIT=$?

    if [ $PYTHON_EXIT -eq 0 ]; then
        log "INFO" "Script Python terminé avec succès."
        echo -e "${GREEN}✅ Rapport généré : $RAPPORT_TXT${NC}"
    else
        log "ERROR" "Le script Python a échoué (code $PYTHON_EXIT)."
        echo -e "${RED}❌ Erreur lors de l'exécution Python. Voir : $LOG_FILE${NC}"
        exit 1
    fi

    # Affichage du rapport dans le terminal
    echo ""
    echo -e "${YELLOW}--- Contenu du rapport ---${NC}"
    cat "$RAPPORT_TXT"
    echo -e "${YELLOW}-------------------------${NC}"

    log "INFO" "=== Analyse terminée ==="
}

main "$@"
