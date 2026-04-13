# 🔎 TP : Analyse des logs Nginx avec Regex

## 👤 Informations

- Nom : Medjkoune Belkacem  
- ID : 300150385  

---

## 🎯 Objectif

Ce laboratoire consiste à analyser un fichier de logs Nginx à l’aide des expressions régulières (Regex), en utilisant deux langages :

- PowerShell
- Python

Le but est d’extraire des informations importantes comme :
- le nombre de requêtes
- les erreurs HTTP
- les adresses IP
- les pages les plus visitées

---


## ⚡ Script PowerShell

![wait](https://github.com/user-attachments/assets/722788d9-e0c8-4e12-9c2a-db91ddd940ba)


👉 Cette capture montre le script PowerShell qui analyse le fichier de logs.  
Il utilise des expressions régulières pour extraire les codes HTTP, les IP et les pages.

---

![wait](https://github.com/user-attachments/assets/b6f1b2f9-265a-4544-b477-6717c42f500d)


👉 Ici on exécute le script avec `pwsh analyse_nginx.ps1`.  
Un fichier rapport est généré automatiquement.

---
![wait](https://github.com/user-attachments/assets/f70efa55-e449-436e-a354-2633fd17ec3f)


👉 Le rapport affiche :
- le total des requêtes  
- les erreurs HTTP  
- les erreurs 404 et 500  
- le top des IP  
- les pages les plus visitées  

---

## 🐍 Script Python

![wait](https://github.com/user-attachments/assets/33f48502-19f3-41b3-8bac-449167fc1081)


👉 Cette capture montre le script Python qui fait la même analyse que PowerShell avec des Regex.

---

![wait](https://github.com/user-attachments/assets/7ceec1ed-4233-4607-9eeb-975280e60ce7)

👉 Le script est exécuté avec `python3 analyse_nginx.py`.  
Un rapport est généré automatiquement.

---

![wait](https://github.com/user-attachments/assets/a0cfbe4e-ad1a-4dcb-9382-c93990c0e125)


👉 Le rapport Python affiche les mêmes informations :
- total des requêtes  
- erreurs  
- IP les plus actives  
- pages les plus consultées  

---

⏰ Automatisation avec CRON

Nous avons configuré une tâche planifiée afin d’exécuter automatiquement le script PowerShell chaque jour.

crontab -e

Commande ajoutée :

0 2 * * * /usr/bin/pwsh /home/ubuntu/REGEX/analyse_nginx.ps1

👉 Cette commande permet d’exécuter le script tous les jours à 2h du matin.

![wait](https://github.com/user-attachments/assets/d48c245b-a0a2-4580-9c0d-9adee7fc45bb)


📝 Commentaire

Cette étape permet d’automatiser l’analyse des logs sans intervention manuelle.
Le système exécute automatiquement le script et génère les rapports chaque jour.

## 📊 Résultats

Les deux scripts donnent des résultats similaires, ce qui confirme que l’analyse est correcte.

Les adresses IP représentent les clients ayant accédé au serveur (données simulées).

---

## 🧠 Conclusion

Ce TP m’a permis de comprendre comment analyser des logs serveur avec des expressions régulières.

J’ai appris à :
- manipuler des fichiers de logs
- utiliser Regex en PowerShell et en Python
- comparer deux approches différentes pour résoudre le même problème

Ce travail m’a aussi aidé à mieux comprendre l’importance de l’analyse des logs en administration système.

---
