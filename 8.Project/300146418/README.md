# Projet INF1102 - Analyse de logs

## Objectif
Ce projet consiste à analyser un fichier de logs web en utilisant des scripts afin de produire :
- un rapport texte automatique
- des figures
- un notebook Jupyter expliquant les résultats

## Structure du projet

```bash
8.Project/
├── scripts/
│   ├── analyse.py
│   └── analyse.ps1
├── data/
│   └── sample.log
├── output/
│   └── rapport.txt
├── images/
│   ├── top_ip.png
│   ├── top_urls.png
│   └── http_status.png
├── RAPPORT.ipynb
└── README.md
```
## Exécution
Python
```bash
python3 scripts/analyse.py
```
## Résultat
```bash
cat output/rapport.txt
ls -l images
```
## Dépendances
Python 3
matplotlib
notebook
Conclusion

Ce projet montre comment automatiser l'analyse d'un fichier log avec Python et générer un rapport lisible avec des figures.
