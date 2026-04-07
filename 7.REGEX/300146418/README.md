# 🧪 TP 7 – Analyse des logs Nginx avec Regex

## 👤 Informations
- Nom : Ikram Sidhoum  
- ID : 300146418  
- Cours : INF1102 – Administration systèmes  
- TP : 7.REGEX  

---

## 🎯 Objectif

Ce TP consiste à analyser les logs Nginx en utilisant des expressions régulières (Regex) avec :

- PowerShell
- Python

Le script doit :
- Lire le fichier `/var/log/nginx/access.log`
- Extraire des informations importantes
- Générer un rapport automatique
- Être automatisé avec cron

---

## 📂 Structure du projet


7.REGEX/
└── 300146418/
├── REGEX/
│ ├── analyse_nginx.ps1
│ ├── analyse_nginx.py
│ ├── rapport_nginx_ps1_YYYY-MM-DD.txt
│ └── rapport_nginx_py_YYYY-MM-DD.txt
├── README.md
└── images/


---

## 📥 Fichier source

```bash
/var/log/nginx/access.log
```
⚙️ Script PowerShell

Exécution :
```bash
pwsh analyse_nginx.ps1
```
Fonctionnalités :

Comptage du nombre total de requêtes
Extraction des codes HTTP
Détection des erreurs (4xx et 5xx)
Analyse des IP les plus actives
Analyse des pages les plus demandées
## 🐍 Script Python

Exécution :
```bash
python3 analyse_nginx.py
```
Fonctionnalités :

Même analyse que PowerShell
Utilisation du module re
Utilisation de Counter pour les statistiques
📊 Résultats

Deux fichiers sont générés :

PowerShell
rapport_nginx_ps1_YYYY-MM-DD.txt
Python
rapport_nginx_py_YYYY-MM-DD.txt

Contenu :

Total requêtes
Nombre d’erreurs HTTP
Nombre d’erreurs 404
Nombre d’erreurs 500
Top 5 IP
Top 5 pages
## 🔍 Expressions régulières utilisées
IP :
(\d{1,3}\.){3}\d{1,3}
Code HTTP :
" (\d{3})
Pages GET :
"GET ([^ ]+)
Erreurs :
(4|5)\d{2}
## ⏰ Automatisation (cron)

Ajout dans crontab :

crontab -e

Ligne utilisée :

0 2 * * * /usr/bin/pwsh /home/ubuntu/Developer/INF1102-201-26H-03/7.REGEX/300146418/REGEX/analyse_nginx.ps1

➡ Exécution automatique tous les jours à 2h

## 🔍 Vérification
crontab -l
ls REGEX
cat REGEX/rapport_nginx_ps1_*.txt
cat REGEX/rapport_nginx_py_*.txt
📸 Captures d’écran

Les captures sont disponibles dans le dossier :


## 🧠 Conclusion

Ce TP permet de :

Maîtriser les expressions régulières
Analyser des logs serveur
Utiliser PowerShell et Python
Automatiser des tâches avec cron
Générer des rapports exploitables
