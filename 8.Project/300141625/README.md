# Projet 8 – Monitoring de site web

## 🎯 Objectif
Ce projet consiste à surveiller la disponibilité d'un site web et mesurer le temps de réponse, à l'aide d'un script Bash et Python, et à générer :
- un **fichier texte** (`output/rapport.txt`) automatique
- un **rapport Jupyter** (`RAPPORT.ipynb`) avec visualisations et commentaires

## 📂 Structure du projet
300141625/
├── scripts/
│   ├── analyse.sh
│   ├── analyse.py
│   └── requirements.txt
├── data/
│   └── sample.log
├── output/
│   └── rapport.txt
├── RAPPORT.ipynb
└── README.md
## ▶️ Exécution

### Bash
```bash
bash scripts/analyse.sh
```

### Python
```bash
python3 scripts/analyse.py data/sample.log
```

## 📦 Dépendances
- Python >= 3.8
- Module Python : `requests`
- Jupyter Notebook

## ✅ Conclusion
Ce projet démontre comment automatiser la surveillance d'un site web et générer des rapports automatiques pour faciliter le diagnostic et la maintenance des systèmes.

## 👤 Auteur
- Nom : Fatou
- ID Boréal : 300141625
