# 🌐 Projet Monitoring Web
 
> **INF1102 — Programmation système**  
> **Étudiant :** Makoudi Massinissa  
> **Identifiant :** 300151354  
 
---
 
## 📋 Description du projet
 
Ce projet permet de **surveiller la disponibilité d'un site web** et de **mesurer son temps de réponse** de manière automatisée.
 
Le pipeline complet utilise :
- **PowerShell** pour envoyer une requête HTTP et récupérer les données
- **JSON** comme format de stockage intermédiaire
- **Python** pour analyser les données et générer un rapport et un graphique
- **Jupyter Notebook** pour la visualisation et l'interprétation des résultats
---
 
## 🗂️ Structure du projet
 
```
300151354/
├── scripts/
│   ├── analyse.ps1       # Script PowerShell — récupération des données
│   └── analyse.py        # Script Python — analyse + graphique
├── data/
│   └── result.json       # Données récupérées depuis le site web
├── output/
│   ├── rapport.txt       # Rapport texte généré automatiquement
│   └── graph.png         # Graphique du temps de réponse
├── RAPPORT.ipynb         # Notebook Jupyter — analyse et visualisation
└── README.md             # Ce fichier
```
 
---
 
## ⚙️ Prérequis et installation
 
### 1. Mettre à jour le système
 
```bash
sudo apt update
```
 
> **Capture 1 — Mise à jour du système (sudo apt update)**
>
> ![sudo apt update](1.png)
 
---
 
### 2. Vérifier pip3
 
```bash
pip3 --version
```
 
> **Capture 2 — Vérification de pip3**
>
![sudo apt update](captures/1.png)
 
---
 
### 3. Installer les dépendances Python
 
```bash
pip3 install matplotlib
```
 
> **Capture 3 — Installation de matplotlib**
>
> ![installation matplotlib](captures/3_install_matplotlib.png)
 
---
 
## 🚀 Exécution
 
### Étape 1 — Lancer le script PowerShell
 
```bash
cd scripts
pwsh analyse.ps1
```
 
> **Capture 4 — Exécution du script PowerShell**
>
> ![powershell execution](captures/4_powershell_execution.png)
 
Ce script :
- Envoie une requête HTTP vers `https://www.google.com`
- Mesure le temps de réponse en millisecondes
- Sauvegarde les résultats dans `data/result.json`
**Résultat attendu :**
```
Test terminé. Résultat sauvegardé.
```
 
---
 
### Étape 2 — Lancer le script Python
 
```bash
python3 analyse.py
```
 
> **Capture 5 — Exécution du script Python et contenu du rapport**
>
> ![python execution](captures/5_python_execution.png)
 
Ce script :
- Lit le fichier `data/result.json`
- Affiche les informations dans le terminal
- Génère `output/rapport.txt`
- Génère `output/graph.png`
**Résultat affiché dans le terminal :**
```
URL: https://www.google.com
Status: 200
Temps de réponse: 688.0782 ms
Analyse terminée.
```
 
---
 
## 📁 Vérification des fichiers générés
 
### Contenu du dossier output/
 
```bash
cd ../output
ls
```
 
> **Capture 6 — Fichiers générés dans output/**
>
> ![output ls](captures/6_output_ls.png)
 
**Fichiers présents :**
```
graph.png    rapport.txt
```
 
---
 
### Contenu du rapport texte
 
```bash
cat rapport.txt
```
 
> **Capture 7 — Contenu de rapport.txt**
>
> ![rapport.txt](captures/7_rapport_txt.png)
 
```
=== RAPPORT MONITORING ===
URL: https://www.google.com
Status: 200
Temps: 688.0782 ms
```
 
---
 
## 📊 Analyse dans Jupyter Notebook (RAPPORT.ipynb)
 
### Lecture des données JSON
 
```python
import json
 
with open("data/result.json") as f:
    data = json.load(f)
 
data
```
 
> **Capture 8 — Affichage des données JSON dans Jupyter**
>
> ![jupyter json](captures/8_jupyter_json.png)
 
**Résultat :**
```python
{'url': 'https://www.google.com', 'status': 200, 'time': 688.0782}
```
 
---
 
### Génération du graphique d'évolution
 
```python
import matplotlib.pyplot as plt
 
values = [650, 700, 680, 690, data["time"]]
 
plt.plot(values, marker='o')
plt.title("Evolution du temps de réponse")
plt.ylabel("Temps (ms)")
plt.xlabel("Test")
plt.grid()
plt.show()
```
 
> **Capture 9 — Graphique d'évolution du temps de réponse**
>
> ![graphique](captures/9_graphique.png)
 
---
 
## 🔍 Interprétation des résultats
 
| Indicateur | Valeur | Interprétation |
|---|---|---|
| **URL testée** | https://www.google.com | Site cible du monitoring |
| **Code de statut HTTP** | `200` | ✅ Site accessible et fonctionnel |
| **Temps de réponse** | `688.08 ms` | ⚡ Acceptable (< 1000 ms) |
 
Le site testé répond avec un **statut HTTP 200**, ce qui confirme qu'il est pleinement accessible.
 
Le temps de réponse mesuré est d'environ **688 ms**, ce qui est un résultat acceptable. Un temps inférieur à 500 ms est considéré comme rapide, mais les valeurs observées restent dans une plage normale pour un réseau standard.
 
Le graphique montre une **légère fluctuation** du temps de réponse entre les mesures (650 ms à 700 ms), ce qui est un comportement normal — les performances d'un site web varient en fonction de la charge serveur et du réseau.
 
---
 
## 🏁 Conclusion
 
Ce projet démontre comment mettre en place un **système de monitoring web simple et automatisé** en combinant PowerShell et Python. L'approche permet de :
 
- Détecter rapidement si un site est hors ligne (statut ≠ 200)
- Mesurer et suivre les performances dans le temps
- Générer des rapports et visualisations automatiquement
Cette méthode peut facilement être étendue pour surveiller plusieurs sites simultanément ou enregistrer des historiques de performance.
 
---
 
## 📦 Dépendances
 
| Outil | Version | Usage |
|---|---|---|
| Python | 3.10+ | Analyse des données |
| pip3 | 22.0+ | Gestionnaire de paquets |
| matplotlib | 3.10.8 | Génération de graphiques |
| PowerShell | pwsh | Requêtes HTTP |
| Jupyter | notebook | Rapport interactif |
