#!/bin/bash

LOGFILE="../data/sample.log"
OUTPUT="../output/rapport.txt"

echo "===== RAPPORT MONITORING SITE WEB =====" > $OUTPUT
echo "Date: $(date)" >> $OUTPUT
echo "" >> $OUTPUT

python3 ../scripts/analyse.py $LOGFILE >> $OUTPUT
