#!/bin/bash

echo "=============================================================="
echo "        CYBERPULSE INTELLIGENCE - ANALYSIS LAUNCHER          "
echo "=============================================================="

if [ ! -d "output" ]; then
    echo "[INFO] Creating output directory..."
    mkdir -p output
fi

if [ ! -f "data/news_data.json" ]; then
    echo "[ERROR] Input file data/news_data.json not found."
    exit 1
fi

echo "[INFO] Running Python analysis engine..."
python3 scripts/analyse.py

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Analysis completed successfully."
    echo "[SUCCESS] Review the generated files in the output directory."
else
    echo "[ERROR] Analysis failed."
    exit 1
fi
