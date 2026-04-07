# 📰 Scraper BBC News — Projet Bash + Python

> **Amel Zourane** | **300150195**
> **INF1102-201-26H-03** | **Collège Boréal** | **2026**

---

## 🎯 Objectif

Ce projet automatise la récupération et l'analyse des nouvelles **BBC News** via flux RSS.
Il extrait les titres, identifie les mots les plus fréquents et génère un rapport complet.

### Ce projet permet de :

- ✅ Récupérer 20 titres BBC News via RSS en temps réel
- ✅ Analyser les mots fréquents avec des expressions régulières
- ✅ Générer un rapport texte automatique
- ✅ Automatiser l'exécution avec PowerShell + Python
- ✅ Documenter les résultats dans un Jupyter Notebook

---

## 🖥️ Environnement

| Élément | Détail |
|--------|--------|
| 💻 Machine | vm300150195 |
| 🌐 IP | 10.7.237.214 |
| 🐧 OS | Ubuntu 22.04 LTS |
| 🐍 Python | 3.x |
| ⚡ PowerShell | 7.6.0 |

---

## 📂 Structure du projet
300150195/
│
├── 📁 scripts/
│   ├── analyse.ps1      # Script PowerShell principal
│   └── analyse.py       # Script Python — scraping + analyse
│
├── 📁 data/
│   └── sample.log       # Fichier de logs
│
├── 📁 output/
│   └── rapport.txt      # Rapport généré automatiquement
│
├── 📁 images/
│   ├── projet1.png      # Résultat script Python
│   ├── projet2.png      # Résultat script PowerShell
│   ├── projet3.png      # Version Jupyter
│   └── projet4.png      # Création RAPPORT.ipynb
│
├── 📄 RAPPORT.ipynb     # Rapport Jupyter Notebook
└── 📄 README.md
---

## ▶️ Exécution

### Script Python
```bash
python3 scripts/analyse.py
```

### Script PowerShell
```bash
pwsh scripts/analyse.ps1
```

---

## 📸 Script Python — Résultats

![Script Python](images/projet1.png)

---

## 📸 Script PowerShell — Résultats

![Script PowerShell](images/projet2.png)

---

## 📸 Jupyter — Version installée

![Jupyter](images/projet3.png)

---

## 📸 Création du RAPPORT.ipynb

![Rapport créé](images/projet4.png)

---

## 📊 Exemple de rapport généré
==================================================
RAPPORT SCRAPER BBC NEWS
Date        : 2026-04-07
Source      : BBC News RSS
Titres      : 20
TOP 10 MOTS LES PLUS FRÉQUENTS :
watch                █████ (3)
kanye                ████ (2)
west                 ████ (2)
artemis              ████ (2)
police               ████ (2)
---

## ✅ Compétences couvertes

| Compétence | Détail |
|-----------|--------|
| 🐍 Python | Scraping RSS, Regex, Counter |
| ⚡ PowerShell | Invoke-RestMethod, Out-File |
| 🔍 Regex | Extraction et analyse de texte |
| 📓 Jupyter | Documentation et visualisation |
| 🐧 Linux | Administration Ubuntu 22.04 |
