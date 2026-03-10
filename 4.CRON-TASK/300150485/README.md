# LAB 4 – CRON TASK

## 🎯 Objectif
Analyser les logs Nginx, extraire les adresses IP,
créer un script Bash et automatiser son exécution avec cron.

---

## 📂 Fichier analysé
/var/log/nginx/access.log

---

## 🔎 Commandes utilisées

### Extraire IP
awk '{print $1}' access.log

### Supprimer doublons
awk '{print $1}' access.log | sort | uniq

### Compter fréquence
awk '{print $1}' access.log | sort | uniq -c | sort -nr

---

## 📝 Script Bash

Fichier : scruter_nginx.sh

```bash
#!/bin/bash
LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="/home/$USER/nginx_ips.txt"
awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE
echo "Script exécuté le $(date)" >> /home/$USER/nginx_execution.log

