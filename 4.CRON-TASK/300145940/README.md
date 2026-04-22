# 🧪 Lab CRON-TASK – Analyse des logs Nginx

## 📌 Objectif
L’objectif de ce laboratoire est de :
- Analyser les logs Nginx
- Extraire les adresses IP uniques
- Automatiser cette tâche avec CRON

---

## ⚙️ Étapes réalisées

### 1. Création du script
Un script Bash nommé `scruter_nginx.sh` a été créé dans `/home/ubuntu/`.

Ce script permet de :
- Lire le fichier `/var/log/nginx/access.log`
- Extraire les adresses IP
- Supprimer les doublons
- Sauvegarder le résultat dans `/home/ubuntu/nginx_ips.txt`
- Ajouter un timestamp dans `/home/ubuntu/nginx_ips.log`

### 2. Donner les permissions
```bash
chmod +x /home/ubuntu/scruter_nginx.sh
