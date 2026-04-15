#!/bin/bash

INPUT="../data/sample.log"
OUTPUT="../output/rapport.txt"

echo "Analyse en cours..." > "$OUTPUT"
python3 analyse.py "$INPUT" >> "$OUTPUT"
echo "Analyse terminee"
