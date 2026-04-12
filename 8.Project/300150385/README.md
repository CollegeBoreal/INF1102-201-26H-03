# Analyse des actualités (BBC)

## Étudiant

* Nom : Medjkoune Belkacem
* ID : 300150385
* Cours : INF1102 – Programmation système

---

## Description du projet

Ce projet a pour objectif d’analyser des actualités provenant du site BBC News.
Le script développé en Python permet de récupérer des titres d’articles, de nettoyer le texte et d’identifier les mots les plus fréquents.

L’analyse est ensuite représentée sous forme de graphique afin de mieux visualiser les résultats.

---

## Fonctionnalités

* Récupération des titres d’actualités (scraping)
* Nettoyage du texte (suppression des caractères inutiles)
* Comptage des mots les plus fréquents
* Génération d’un fichier JSON
* Création d’un graphique (histogramme)
* Génération d’un rapport texte
* Notebook Jupyter pour l’analyse

---

## Technologies utilisées

* Python 3
* requests
* BeautifulSoup
* pandas
* matplotlib

---

## Structure du projet

```
300150385/
├── scripts/
│   ├── analyse.py
│   └── analyse.ps1
├── data/
│   └── news_data.json
├── output/
│   ├── histogram.png
│   └── rapport.txt
├── images/
├── RAPPORT.ipynb
└── README.md
```

---

## Installation

Installer les dépendances nécessaires :

```
python -m pip install requests beautifulsoup4 pandas matplotlib
```

---

## Exécution du projet

### Méthode PowerShell

```
cd scripts
.\analyse.ps1
```

### Méthode Python directe

```
cd scripts
python analyse.py
```

---

## Résultats obtenus

Après l’exécution du script, les fichiers suivants sont générés :

* `data/news_data.json` : contient les mots les plus fréquents
* `output/histogram.png` : graphique des résultats
* `output/rapport.txt` : résumé de l’analyse

---

## Analyse

Les résultats montrent les mots les plus fréquents dans les titres des actualités.

On remarque que plusieurs mots ont la même fréquence, ce qui indique qu’il n’y a pas de sujet dominant dans cet échantillon. Cela s’explique par la diversité des actualités analysées.

---

## Conclusion

Ce projet m’a permis de mieux comprendre comment récupérer et analyser des données depuis un site web.

J’ai également appris à utiliser différentes bibliothèques Python pour le traitement et la visualisation des données.

---

## Captures

### Exécution du script

## Captures

### 1. Code principal (analyse.py)

![wait](https://github.com/user-attachments/assets/67250537-9cdb-4ba6-8167-f442aa2016dd)


### 2. Installation des dépendances

![wait](https://github.com/user-attachments/assets/c8ba9a40-8c78-4509-893a-6a0e9234dc0a)


### 3. Exécution du script PowerShell

![wait](https://github.com/user-attachments/assets/c50d3cc7-bad1-41cc-8e67-05db9c3de558)


### 4. Résultat dans Jupyter Notebook

![wait](https://github.com/user-attachments/assets/5d109414-515f-4a67-b22f-589f0c99dbba)


### 5. Résultat graphique généré

---
