## TP CRON - Surveillance Nginx
## 🌐 IP de la VM
10.7.237.210


## 👩‍💻 Étudiante

\- Nom : Ikram Sidhoum  

\- ID : 300146418  

\- Cours : INF1102 - Administration Linux  



\---



## 🎯 Objectif du TP

Surveiller le système Linux et analyser les logs du serveur Nginx afin de :

\- Extraire les adresses IP des visiteurs

\- Automatiser cette tâche avec cron



\---



## ⚙️ Outils utilisés

\- awk

\- sort

\- uniq

\- cron

\- journalctl



\---



## 📂 Fichiers

\- `scruter\_nginx.sh` → Script pour extraire les IP

\- `nginx\_ips.txt` → Fichier contenant les IP uniques

\- `nginx\_ips.log` → Log d'exécution du script



\---



## 🧠 Fonctionnement du script



Le script :

1\. Lit le fichier `/var/log/nginx/access.log`

2\. Extrait les adresses IP (colonne 1)

3\. Supprime les doublons

4\. Enregistre le résultat dans un fichier



\---



## 💻 Script utilisé



```bash

\#!/bin/bash



LOG\_FILE="/var/log/nginx/access.log"

OUTPUT\_FILE="/home/ubuntu/nginx\_ips.txt"



awk '{print $1}' $LOG\_FILE | sort | uniq > $OUTPUT\_FILE



echo "Script exécuté le $(date)" >> /home/ubuntu/nginx\_ips.log
```

##⏱️ Automatisation avec cron

Commande utilisée :

crontab -e

Ligne ajoutée :

0 * * * * /home/ubuntu/scruter_nginx.sh

➡️ Le script s’exécute chaque heure automatiquement.

## 🔍 Exemple de résultat
10.250.1.32
## ✅ Conclusion

Ce TP m’a permis de :

Comprendre l’analyse des logs Linux
Utiliser awk pour manipuler les données
Automatiser des tâches avec cron
Surveiller un serveur en temps réel

---

# 🚀 APRÈS


```bash
git add README.md
git commit -m "README personnalisé"
git push
```




