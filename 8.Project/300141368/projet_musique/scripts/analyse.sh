#!/bin/bash

API_KEY="f73da1b80dff0e1376ac0cbdd0fb19e8"
USER="DaniellaDiwa18"

mkdir -p ../data
mkdir -p ../output

OUTPUT_JSON="../data/music.json"
OUTPUT_TXT="../output/rapport.txt"

echo "📡 Récupération des données Last.fm..."

curl "http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=$USER&api_key=$API_KEY&format=json" -o $OUTPUT_JSON

echo "📊 Analyse des données..."

python3 ../scripts/analyse.py $OUTPUT_JSON $OUTPUT_TXT

echo "✅ Rapport généré dans output/rapport.txt"
