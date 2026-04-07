## 👤 Étudiant

- Identifiant : **300133071**
- Nom: Nelson William
- Cours : Programmation système 
- Thème : **News Analyser — Scraping & Analyse de texte**

# 📰 News Analyser — Scraping & Analyse de texte

Projet Python complet pour scrapper des actualités (BBC ou CNN),
analyser la fréquence des mots et générer des visualisations.

---

## 🗂️ Structure du projet

```
├── scripts/
│   ├── analyse.py      ← Script Python principal
│   └── analyse.ps1     ← Lanceur PowerShell (Windows)
├── data/
│   └── news_data.json  ← Données brutes (généré automatiquement)
├── output/
│   ├── histogram.png   ← Graphique top 10 mots
│   ├── wordcloud.png   ← Nuage de mots (si wordcloud installé)
│   └── rapport.txt     ← Rapport texte
├── RAPPORT.ipynb       ← Notebook Jupyter interactif
└── README.md
```

---

## 🚀 Lancement rapide

### Option A — PowerShell (Windows recommandé)
```powershell
cd scripts
.\analyse.ps1              # BBC par défaut
.\analyse.ps1 -Site cnn    # CNN
```

### Option B — Python direct
```bash
cd scripts
python analyse.py              # BBC par défaut
python analyse.py --site cnn   # CNN
```

---

## 📦 Dépendances Python

```bash
pip install requests beautifulsoup4 matplotlib pandas
pip install wordcloud   # Optionnel (nuage de mots)
```

---

## 📓 Notebook Jupyter

```bash
pip install jupyter
jupyter notebook RAPPORT.ipynb
```

---

## ✅ Fonctionnalités

| Fonctionnalité | Statut |
|----------------|--------|
| Scraping BBC News | ✅ |
| Scraping CNN | ✅ |
| Nettoyage du texte (stopwords, ponctuation) | ✅ |
| Top 10 mots fréquents | ✅ |
| Histogramme | ✅ |
| Nuage de mots | ✅ (optionnel) |
| Export JSON | ✅ |
| Rapport texte | ✅ |
| Notebook Jupyter | ✅ |
| Délais entre requêtes (poli) | ✅ |
| User-Agent réaliste | ✅ |
| Gestion des erreurs | ✅ |
