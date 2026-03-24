# 📽️ Project

**5 idées de projets Web Scraping / API / automatisation** adaptées au cours, avec **consignes, scripts, Notebook et livrables attendus**, prêts à distribuer aux étudiants.

---

## :one: **Projet 1 : Suivi de météo quotidienne**

**Objectif :** Récupérer les données météo d’une ville via l’API OpenWeatherMap et générer un rapport texte + Notebook avec graphiques.

**Livrables attendus :**

* `scripts/analyse.ps1` : récupère les données JSON de l’API chaque jour
* `scripts/analyse.py` : analyse et génère statistiques + graphique
* `RAPPORT.ipynb` : visualisation des températures, humidité, conditions météo
* `output/rapport.txt` : résumé texte quotidien

**Exemple PowerShell :**

```powershell
# analyse.ps1
$city = "Toronto,CA"
$apiKey = "VOTRE_API_KEY"
$outputFile = "../output/rapport.txt"

$response = Invoke-RestMethod -Uri "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric"
$response | ConvertTo-Json | Out-File $outputFile

# Appel Python pour analyse
python3 ../scripts/analyse.py $outputFile
```

**Exemple Python :**

```python
import sys, json, matplotlib.pyplot as plt

file = sys.argv[1]
with open(file) as f:
    data = json.load(f)

temp = data['main']['temp']
humidity = data['main']['humidity']

print(f"Température: {temp} °C, Humidité: {humidity}%")
plt.bar(['Température','Humidité'], [temp, humidity])
plt.savefig('../output/meteo.png')
```

---

## :two: **Projet 2 : Scraper de nouvelles**

**Objectif :** Récupérer les titres et résumés d’un site d’actualités (ex. CNN ou BBC) et analyser les mots les plus fréquents.

**Livrables attendus :**

* `scripts/analyse.ps1` : exécute le scraping Python
* `scripts/analyse.py` : collecte titres, compte mots, génère histogramme
* `RAPPORT.ipynb` : visualisation mots fréquents et résumé
* `output/rapport.txt` : top 10 mots clés

**Astuce pédagogique :** Utiliser `requests` et `BeautifulSoup` en Python.

---

## :three: **Projet 3 : Suivi de prix de produits e-commerce**

**Objectif :** Suivre quotidiennement le prix d’un produit sur un site public et générer un graphique d’évolution.

**Livrables attendus :**

* `scripts/analyse.ps1` : planification quotidienne
* `scripts/analyse.py` : scraping du prix et enregistrement dans CSV
* `RAPPORT.ipynb` : graphique de l’évolution du prix
* `output/rapport.txt` : prix actuel et variation depuis la dernière récupération

**Astuce pédagogique :** Vérifier que le site autorise le scraping, ou utiliser une API publique.

---

## :four: **Projet 4 : Analyse de données COVID via API publique**

**Objectif :** Récupérer les statistiques COVID par pays et générer analyses et graphiques.

**Livrables attendus :**

* `scripts/analyse.ps1` : récupère les données via API
* `scripts/analyse.py` : analyse cas, décès, guérisons et génère graphiques
* `RAPPORT.ipynb` : évolution des cas dans un ou plusieurs pays
* `output/rapport.txt` : résumé texte des statistiques principales

**Astuce pédagogique :** API recommandée : `https://covid19api.com/`

---

## :five: **Projet 5 : Monitoring site web**

**Objectif :** Vérifier la disponibilité d’un site web et mesurer le temps de réponse.

**Livrables attendus :**

* `scripts/analyse.ps1` : ping HTTP du site et journalisation
* `scripts/analyse.py` : analyse temps de réponse et erreurs
* `RAPPORT.ipynb` : graphique des temps de réponse sur plusieurs jours
* `output/rapport.txt` : résumé des statuts et alertes

**Astuce pédagogique :** Utiliser `requests.get(url)` en Python pour vérifier le code HTTP.

---

### **Conseils généraux pour tous les projets**

* **PowerShell** : exécuter le script principal et générer fichier JSON ou CSV
* **Python** : traiter les données, générer graphique ou résumé
* **Jupyter Notebook** : analyser et commenter les résultats
* **Livrables obligatoires** : `scripts/`, `output/rapport.txt`, `RAPPORT.ipynb`, `README.md`

---

# 🧪 Projet:

---


## ⭕ Objectifs

Créer un projet permettan l'utilisation des languages de scripts appris en cours.

---

## **1. Structure de projet mise à jour**

- [ ] sur votre 🎰 ***VM***

```bash
🆔/
│
├── scripts/
│   ├── analyse.sh       # Script Bash principal
│   └── analyse.py       # Script Python appelé par Bash
│
├── data/
│   └── sample.log       # Fichier d’exemple pour tests
│
├── output/
│   └── rapport.txt      # Fichier généré automatiquement
│
├── RAPPORT.ipynb        # Rapport Jupyter Notebook
└── README.md            # Instructions d’exécution + explications
```

---

## **2. README type mis à jour**

````md
# Projet Bash + Python

## 1. Objectif
Ce projet consiste à analyser un fichier log (`data/sample.log`) à l’aide d’un script Bash et Python, et à générer :
- un **fichier texte** (`output/rapport.txt`) automatique
- un **rapport Jupyter** (`RAPPORT.ipynb`) avec visualisations et commentaires

## 2. Structure du projet
- `scripts/analyse.sh` : script Bash principal
- `scripts/analyse.py` : script Python appelé par Bash
- `data/sample.log` : fichier d’exemple
- `output/rapport.txt` : fichier généré automatiquement
- `RAPPORT.ipynb` : rapport détaillé avec analyses et graphiques
- `README.md` : instructions et explications

## 3. Exécution
1. Exécuter le script Bash principal :
```bash
bash scripts/analyse.sh
````

2. Ou exécuter le script Python seul :

```bash
python3 scripts/analyse.py data/sample.log
```

3. Ouvrir `RAPPORT.ipynb` avec **Jupyter Notebook** ou **Jupyter Lab** pour le rapport écrit.

## 4. Dépendances

* Bash
* Python >= 3.8
* Modules Python : `re`, `collections`, `matplotlib` (optionnel pour graphiques)
* Jupyter Notebook

## 5. Résultat attendu

* `output/rapport.txt` : statistiques principales (top IP, top URLs)
* `RAPPORT.ipynb` : explications, visualisations, analyse approfondie

## 6. Bonnes pratiques

* Scripts lisibles et commentés
* Respecter la structure de dossier
* RAPPORT.ipynb doit contenir du texte explicatif et éventuellement des graphiques

---

## **4. Conseils**

1. Tester **analyse.sh** et **analyse.py** avant livraison.
2. Générer **output/rapport.txt** automatiquement avec Bash + Python.
3. Compléter **RAPPORT.ipynb** avec :

   * description de la méthode
   * statistiques ou graphiques
   * analyse des résultats
4. Respecter la **structure de dossiers** pour que le script de test fonctionne.
5. Commenter le code pour que ce soit clair pour le correcteur.

---
