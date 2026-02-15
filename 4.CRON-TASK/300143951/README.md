# 👁️ Big Brother - Surveillance Nginx

## 1️⃣  Introduction

**Nginx**, serveur web très populaire, enregistre toutes les requêtes dans des fichiers de logs. Il existe principalement deux types de logs :
- **access.log** : contient toutes les requêtes reçues (pages visitées, adresses IP, statut HTTP…)
- **error.log** : contient les erreurs du serveur

### Objectif de l'exercice :
- Extraire toutes les adresses IP qui visitent le site
- Stocker ces IP dans un fichier
- Automatiser la tâche pour qu'elle s'exécute toutes les heures



---


## 2️⃣ Créer un script shell automatisé

### Créer le fichier `scruter_nginx.sh` :
```bash
nano /home/ubuntu/scruter_nginx.sh
```

### Contenu du script (annoté ligne par ligne) :
ce strip permet de ressortir toutes les adresse ip qui on visitee le site tout en affichant le nombre de visites par adresse et leeur ordre d'anciennetee.

```bash
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
```

### Rendre le script exécutable :
```bash
chmod +x /home/ubuntu/scruter_nginx.sh
```

### Tester le script :
```bash
/home/ubuntu/scruter_nginx.sh
cat /home/ubuntu/nginx_ips.txt
```

![Exécution du script](image/scrip_shell_automatisee.png)
*Résultat : 60 visites de l'IP 10.250.3.68*

---

##  3️⃣ Automatiser avec cron (toutes les heures)

### Éditer le crontab :
```bash
crontab -e
```

![Configuration du crontab](image/auto_chrontab.png)
*Ajout de la ligne pour automatiser l'exécution*

### Ajouter cette ligne :
```bash
0 * * * * /home/ubuntu/scruter_nginx.sh
```
- `0 * * * *` → à la minute 0 de chaque heure
- `/home/ubuntu/scruter_nginx.sh` → chemin du script

### Vérifier que le cron est actif :
```bash
systemctl status cron
```

![Vérification du service cron](image/verification_chrontab.png)
*Le service cron est actif et fonctionne correctement*



---

## 4️⃣ Bonus : IP les plus fréquentes

Pour détecter les visiteurs les plus actifs :

```bash
awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -nr > /home/ubuntu/nginx_ips_freq.txt
```

- `uniq -c` → compte le nombre d'occurrences
- `sort -nr` → trie par fréquence décroissante

![Extraction manuelle](image/etraction_manuelle_d_ip.png)
*Vérification manuelle des IPs avec compteur de fréquence*

---

## 5️⃣📝 Notes importantes

- Le script nécessite `sudo` pour lire `/var/log/nginx/access.log`
- Le fichier `nginx_ips.log` garde l'historique des exécutions

---

**Auteur** : frank kadji  
**Date** : Février 2026
