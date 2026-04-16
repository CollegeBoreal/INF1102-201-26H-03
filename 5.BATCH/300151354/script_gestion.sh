#!/bin/bash

LOG="./log.txt"
DATE=$(date)

echo "===================================" >> "$LOG"
echo "Début exécution : $DATE" >> "$LOG"

echo "Test réseau..." >> "$LOG"
ping -c 4 8.8.8.8 >> "$LOG" 2>&1

echo "Création dossiers..." >> "$LOG"
mkdir -p ./entreprise/data ./entreprise/backup ./entreprise/logs

echo "Création fichiers test..." >> "$LOG"
echo "test1" > ./entreprise/data/file1.txt
echo "test2" > ./entreprise/data/file2.txt

echo "Sauvegarde..." >> "$LOG"
cp -r ./entreprise/data/* ./entreprise/backup/ >> "$LOG" 2>&1

echo "Compression..." >> "$LOG"
tar -czvf ./entreprise/backup/backup_$(date +%F).tar.gz ./entreprise/data >> "$LOG" 2>&1

echo "Fin exécution : $(date)" >> "$LOG"
echo "===================================" >> "$LOG"
