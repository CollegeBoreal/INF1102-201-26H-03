#!/bin/bash

LOG_FILE="../data/sample.log"
OUTPUT_DIR="../output"
REPORT_FILE="$OUTPUT_DIR/rapport.txt"

mkdir -p "$OUTPUT_DIR"

echo "Analyse en cours..."

python3 analyse.py "$LOG_FILE"

echo "Terminé ✔️"
