 Ouvre README.md et mets ça :

# Analyse des actualités (BBC)

## Étudiant
- Nom : Medjkoune Belkacem  
- ID : 300150385  
- Cours : INF1102 – Programmation système  

---

## Description du projet

Ce projet consiste à récupérer des actualités depuis le site BBC News et à analyser les mots les plus fréquents dans les titres.

Le script Python permet de :
- récupérer les titres des articles
- nettoyer le texte
- compter les mots les plus utilisés
- générer un graphique (histogramme)
- créer un fichier texte avec les résultats

---

## Technologies utilisées

- Python 3
- BeautifulSoup (scraping)
- Requests
- Matplotlib

---

## Structure du projet
300150385/
├── scripts/
│ ├── analyse.py
│ └── analyse.ps1
├── data/
│ └── news_data.json
├── output/
│ ├── histogram.png
│ └── rapport.txt
├── RAPPORT.ipynb
└── README.md# Analyse des actualités (BBC)


---

## Comment exécuter le projet

### 1. Installer les dépendances
```bash
python -m pip install beautifulsoup4 requests matplotlib
2. Lancer l’analyse (PowerShell)
cd scripts
.\analyse.ps1

