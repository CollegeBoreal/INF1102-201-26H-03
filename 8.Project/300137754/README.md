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
