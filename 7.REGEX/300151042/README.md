# 300151042 — hamdi hicham

## 📚 TP — Analyse des logs Nginx avec Regex
### Cours : INF1102-201-26H-03

## 🖥️ Informations de la VM

| Élément | Valeur |
|---------|--------|
| Étudiant | hamdi hicham |
| Numéro | 300151042 |
| Machine | vm300151042 |
| IP | 10.7.237.220 |
| OS | Ubuntu 22.04 (Jammy) |

## 📋 Description

Scripts d'analyse des logs Nginx avec expressions régulières.
Génère automatiquement un rapport texte avec PowerShell et Python.
## 🎯 Objectif

Ce TP vise à automatiser l'analyse des logs du serveur web **Nginx**
en exploitant la puissance des **expressions régulières (Regex)**
dans deux langages complémentaires : **PowerShell** et **Python**.

### Ce TP permet de :

- ✅ Lire et analyser `/var/log/nginx/access.log`
- ✅ Extraire les adresses IP, codes HTTP et pages visitées avec des Regex
- ✅ Identifier et comptabiliser les erreurs HTTP (404, 500)
- ✅ Générer des rapports automatiques en `.txt`
- ✅ Classer le Top 5 des IP et pages les plus actives
- ✅ Automatiser l'exécution avec une tâche **cron**



## 📊 Rapport PowerShell

Rapport Nginx - 2026-04-07 21:02:30
----------------------------------
Total requêtes : 2
Erreurs HTTP : 1
Erreurs 404 : 1
Erreurs 500 : 0

Top 5 IP :
2 127.0.0.1

Top 5 pages :
1 /
1 /index.html


## 📊 Rapport Python

Rapport Nginx - 2026-04-07 21:02:30
----------------------------------
Total requêtes : 2
Erreurs HTTP : 1
Erreurs 404 : 1
Erreurs 500 : 0

Top 5 IP :
2 127.0.0.1

Top 5 pages :
1 /
1 /index.html


## ▶️ Exécution
```bash
pwsh ./REGEX/analyse_nginx.ps1
python3 ./REGEX/analyse_nginx.py
```

## ⏰ Automatisation avec Cron

Le script PowerShell est planifié pour s'exécuter automatiquement chaque nuit à 2h00 :
```bash
crontab -e
```
```
0 2 * * * /usr/bin/pwsh /home/ubuntu/REGEX/analyse_nginx.ps1
```

Vérification :
```bash
grep CRON /var/log/syslog
```

---
## ✅ Compétences couvertes

| Compétence | Détail |
|-----------|--------|
| 🔍 Regex | Extraction de données structurées |
| ⚡ PowerShell | Analyse de logs et rapports |
| 🐍 Python | Traitement de texte avec `re` |
| ⏰ Cron | Automatisation de tâches |
| 🐧 Linux | Administration Ubuntu 22.04 |
