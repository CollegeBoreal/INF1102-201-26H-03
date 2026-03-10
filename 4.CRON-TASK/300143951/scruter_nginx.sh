#!/bin/bash
# ↑ Indique que le script doit être exécuté avec Bash

# Fichier des logs
LOG_FILE="/var/log/nginx/access.log"
# ↑ Chemin vers le fichier de logs Nginx (contient toutes les requêtes)

# Fichier de sortie
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"
# ↑ Où sauvegarder les résultats de l'analyse

# Ajouter un en-tête avec timestamp
echo "========================================" > $OUTPUT_FILE
# ↑ Crée/écrase le fichier avec une ligne de séparation visuelle

echo "Rapport d'analyse Nginx - $(date '+%Y-%m-%d %H:%M:%S')" >> $OUTPUT_FILE
# ↑ Ajoute la date/heure actuelle au format AAAA-MM-JJ HH:MM:SS

echo "========================================" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
# ↑ Ligne vide pour la lisibilité

# Extraire les IPs avec compteur de visites
echo "Nombre de visites par IP (du plus fréquent au moins fréquent) :" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

sudo awk '{print $1}' $LOG_FILE | \
    sort | \
    uniq -c | \
    sort -rn >> $OUTPUT_FILE
# ↑ Explication ligne par ligne :
#   - sudo : permissions nécessaires pour lire les logs
#   - awk '{print $1}' : extrait la 1ère colonne (l'IP)
#   - sort : trie les IPs alphabétiquement
#   - uniq -c : compte les doublons et les supprime
#   - sort -rn : trie par nombre (-n) en ordre décroissant (-r)

# Ajouter les statistiques globales
echo "" >> $OUTPUT_FILE
echo "----------------------------------------" >> $OUTPUT_FILE

TOTAL=$(sudo awk '{print $1}' $LOG_FILE | wc -l)
# ↑ Compte le nombre total de requêtes

UNIQUE=$(sudo awk '{print $1}' $LOG_FILE | sort -u | wc -l)
# ↑ Compte le nombre d'IPs uniques (sort -u = unique)

echo "Total de requêtes : $TOTAL" >> $OUTPUT_FILE
echo "IPs uniques : $UNIQUE" >> $OUTPUT_FILE

# Log d'exécution
echo "Script exécuté le $(date -I'seconds')" >> /home/ubuntu/nginx_ips.log
# ↑ Enregistre quand le script a tourné (format ISO 8601)
