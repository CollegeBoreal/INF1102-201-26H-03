#     LAB Surveillance Nginx

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
ce script permet de ressortir toutes les adresse ip qui on visitee le site tout en affichant le nombre de visites par adresse et leeur ordre d'anciennetee.

[![Script](https://img.shields.io/badge/script-scruter__nginx.sh-blue)](./scruter_nginx.sh)

### Rendre le script exécutable :
```bash
chmod +x /home/ubuntu/scruter_nginx.sh
```

### Tester le script :
```bash
/home/ubuntu/scruter_nginx.sh
cat /home/ubuntu/nginx_ips.txt
```
# <p align="center"><img src="images//scrip shell automatisee.png" alt="Images" width="450"/></p>
*Résultat : 60 visites de l'IP 10.250.3.68*

---

##  3️⃣ Automatiser avec cron (toutes les heures)

### Éditer le crontab :
```bash
crontab -e
```
# <p align="center"><img src="images//auto chrontab.png" alt="Images" width="450"/></p>
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
# <p align="center"><img src="images//verification chrontab.png" alt="Images" width="450"/></p>
*Le service cron est actif et fonctionne correctement*



---

## 4️⃣ verification manuelle des IP les plus fréquentes

Pour détecter les visiteurs les plus actifs :

```bash
awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -nr > /home/ubuntu/nginx_ips_freq.txt
```

- `uniq -c` → compte le nombre d'occurrences
- `sort -nr` → trie par fréquence décroissante

# <p align="center"><img src="images//etraction manuelle d'ip.png" alt="Images" width="450"/></p>
*Vérification manuelle des IPs avec compteur de fréquence*

---

## 5️⃣📝 Notes importantes

- Le script nécessite `sudo` pour lire `/var/log/nginx/access.log`
- Le fichier `nginx_ips.log` garde l'historique des exécutions

---

**Auteur** : frank kadji  
**Date** : Février 2026



