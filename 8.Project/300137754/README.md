# 📊 Projet 3 – Suivi de prix de produits e-commerce

**Nom :** Beni Joseph Ephraim Mundhu  
**Numéro étudiant :** 300137754  
**Cours :** INF1102-201-26H-03  

---

## 🎯 Objectif

Ce projet permet de suivre le prix d’un produit sur un site web, d’enregistrer les données dans un fichier CSV, puis de générer un rapport et un graphique d’évolution des prix.

---

## 🗂️ Structure du projet
```
300137754/
├── scripts/
│   ├── analyse.sh          # Orchestrateur Bash (vérif. env + appel Python)
│   ├── analyse.py          # Scraping API + écriture CSV + rapport.txt
│   └── requirements.txt    # Dépendances Python
│
├── data/
│   ├── prices.csv          # Historique des prix 
│   └── scraping.log        # Log d'exécution
│
├── output/
│   ├── rapport.txt         # Rapport texte (prix actuel + variation)
│   ├── graph_evolution.png # Courbes d'évolution (généré par Jupyter)
│   └── graph_variation.png # Variation J/J-1 (généré par Jupyter)
│
├── RAPPORT.ipynb           # Notebook Jupyter avec graphiques et analyses
└── README.md               # Ce fichier
```
Pour afficher la structure du projet on tape la commande:
```
tree /f
```
---
## ⚙️ Scripts
analyse.ps1

Script PowerShell qui :

exécute le script Python
planifie ou automatise la récupération des données
```
Get-Content .\scripts\analyse.ps1
```
<img width="1070" height="425" alt="get-content-ps1" src="https://github.com/user-attachments/assets/b8667163-43e4-4d1a-8d40-15538995aa62" />

---
analyse.py

Script Python qui :

récupère le prix (scraping)
enregistre dans data/prices.csv
génère output/rapport.txt
```
Get-Content .\scripts\analyse.py
```
<img width="1106" height="612" alt="get_content-py" src="https://github.com/user-attachments/assets/9b63fcf8-9398-498c-b6d2-9f94681c760e" />

---
## 📄 Fichier CSV

Le fichier data/prices.csv contient :
```
date
heure
produit
prix
url
```
<img width="948" height="406" alt="prices-csv" src="https://github.com/user-attachments/assets/079d72e8-b37d-4eee-aa91-3fe729c9f0ec" />

---
## 📈 Résultats
🧾 Rapport texte
```
Get-Content .\output\rapport.txt
```
<img width="1088" height="566" alt="rapport-txt" src="https://github.com/user-attachments/assets/e0807f7a-f97b-459b-a493-5839f2e43d96" />

---
