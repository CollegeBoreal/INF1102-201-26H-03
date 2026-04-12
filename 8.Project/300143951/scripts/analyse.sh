#!/bin/bash
# =============================================================
#  Projet IDH Afrique — Script Bash principal
#  Étudiant : Frank Laurel | ID : 300143951
#  Cours    : TSI — Collège Boréal — Session Hiver 2025
# =============================================================

# ─── Couleurs terminal ─────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ─── Chemins ───────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="$PROJECT_DIR/output"
LOG_FILE="$OUTPUT_DIR/execution.log"
VENV_DIR="$PROJECT_DIR/venv"

# ─── Fonctions utilitaires ─────────────────────────────────
log_info()    { echo -e "${CYAN}[INFO]${NC}  $1" | tee -a "$LOG_FILE"; }
log_success() { echo -e "${GREEN}[OK]${NC}    $1" | tee -a "$LOG_FILE"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $1" | tee -a "$LOG_FILE"; }
log_error()   { echo -e "${RED}[ERREUR]${NC} $1" | tee -a "$LOG_FILE"; }

banner() {
    echo -e "${BOLD}${CYAN}"
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║    PROJET IDH AFRIQUE — Frank Laurel 300143951      ║"
    echo "║    Collège Boréal — TSI — Session Hiver 2025        ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# ─── Vérification des dépendances système ──────────────────
check_dependencies() {
    log_info "Vérification des dépendances système..."
    local missing=0

    for cmd in python3 pip3 curl; do
        if command -v "$cmd" &>/dev/null; then
            log_success "$cmd trouvé : $(command -v $cmd)"
        else
            log_error "$cmd est introuvable — installation requise"
            missing=$((missing + 1))
        fi
    done

    if [ "$missing" -gt 0 ]; then
        log_error "Dépendances manquantes. Arrêt du script."
        exit 1
    fi
}

# ─── Vérification connectivité API ─────────────────────────
check_api_connectivity() {
    log_info "Test de connectivité vers l'API World Bank..."
    local url="https://api.worldbank.org/v2/country/CM/indicator/NY.GDP.PCAP.CD?format=json&per_page=1"
    
    if curl -s --max-time 10 "$url" > /dev/null 2>&1; then
        log_success "API World Bank accessible."
    else
        log_warn "API World Bank inaccessible. Le script continuera mais les données réelles ne seront pas disponibles."
    fi
}

# ─── Création des dossiers ──────────────────────────────────
create_directories() {
    log_info "Vérification de la structure des dossiers..."
    local dirs=("$OUTPUT_DIR" "$PROJECT_DIR/data/raw" "$PROJECT_DIR/notebooks")
    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            log_success "Dossier créé : $dir"
        else
            log_info "Dossier existant : $dir"
        fi
    done
}

# ─── Environnement Python virtuel ──────────────────────────
setup_python_env() {
    log_info "Configuration de l'environnement Python..."

    if [ ! -d "$VENV_DIR" ]; then
        log_info "Création du virtualenv..."
        python3 -m venv "$VENV_DIR"
        log_success "Virtualenv créé : $VENV_DIR"
    fi

    # Activation
    source "$VENV_DIR/bin/activate"
    log_success "Virtualenv activé."

    # Installation des dépendances
    log_info "Installation des dépendances Python..."
    pip install -q -r "$SCRIPT_DIR/requirements.txt" 2>&1 | tee -a "$LOG_FILE"
    log_success "Dépendances installées."
}

# ─── Exécution de l'analyse Python ─────────────────────────
run_analysis() {
    local mode="$1"
    log_info "Lancement de l'analyse Python..."

    if [ "$mode" = "--dry-run" ]; then
        log_warn "MODE TEST ACTIVÉ — Données simulées (pas d'appels API réels)"
        python3 "$SCRIPT_DIR/analyse.py" --dry-run 2>&1 | tee -a "$LOG_FILE"
    else
        python3 "$SCRIPT_DIR/analyse.py" 2>&1 | tee -a "$LOG_FILE"
    fi

    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        log_success "Analyse Python terminée avec succès."
    else
        log_error "Erreur lors de l'analyse Python (code : $exit_code)"
        exit $exit_code
    fi
}

# ─── Résumé final ───────────────────────────────────────────
print_summary() {
    echo ""
    echo -e "${BOLD}${GREEN}══════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${GREEN}  ✅ ANALYSE IDH AFRIQUE TERMINÉE${NC}"
    echo -e "${BOLD}${GREEN}══════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "  📄 Rapport texte  : ${CYAN}$OUTPUT_DIR/rapport.txt${NC}"
    echo -e "  📊 Graphiques     : ${CYAN}$OUTPUT_DIR/graph_*.png${NC}"
    echo -e "  🗺️  Heatmap        : ${CYAN}$OUTPUT_DIR/heatmap_idh.png${NC}"
    echo -e "  📂 Données CSV    : ${CYAN}$PROJECT_DIR/data/raw/*.csv${NC}"
    echo -e "  📓 Notebook       : ${CYAN}$PROJECT_DIR/RAPPORT.ipynb${NC}"
    echo ""
    echo -e "  Pour ouvrir le Notebook Jupyter :"
    echo -e "  ${YELLOW}jupyter notebook --no-browser --ip=0.0.0.0 --port=8888${NC}"
    echo ""
}

# ─────────────────────────────────────────────
#  PROGRAMME PRINCIPAL
# ─────────────────────────────────────────────
main() {
    local start_time
    start_time=$(date '+%Y-%m-%d %H:%M:%S')
    
    mkdir -p "$OUTPUT_DIR"
    echo "" >> "$LOG_FILE"
    echo "═══ Exécution : $start_time ═══" >> "$LOG_FILE"

    banner
    check_dependencies
    check_api_connectivity
    create_directories
    setup_python_env
    run_analysis "$1"
    print_summary
}

# ─── Gestion des arguments ─────────────────────────────────
case "$1" in
    --dry-run|-d)
        main "--dry-run"
        ;;
    --help|-h)
        echo "Usage: bash analyse.sh [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --dry-run, -d   Mode test (données simulées, pas d'appels API)"
        echo "  --help,    -h   Affiche cette aide"
        echo ""
        echo "Exemple:"
        echo "  bash scripts/analyse.sh           # Analyse complète"
        echo "  bash scripts/analyse.sh --dry-run # Mode test"
        ;;
    *)
        main ""
        ;;
esac
