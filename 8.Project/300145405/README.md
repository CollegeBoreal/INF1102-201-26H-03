👤 Étudiant
Identifiant : 300145405
Nom : Elhadj Sadou Barry
Cours : Programmation système
Thème : Surveillance du site web


# Projet 5 : Monitoring de site web

## 1. Objectif

Ce projet consiste à surveiller la disponibilité d'un site web en mesurant
son temps de réponse et son code HTTP à intervalles réguliers.
Le projet utilise un script Bash pour collecter les données et un script Python
pour analyser les résultats et générer un rapport.

Livrables générés automatiquement :
- `output/rapport.txt` : résumé des statuts et alertes
- `RAPPORT.ipynb`      : graphique des temps de réponse et analyse

---

## 2. Structure du projet

```
projet5/
│
├── scripts/
│   ├── analyse.sh       # Script Bash principal (collecte des données)
│   ├── analyse.py       # Script Python (analyse + rapport)
│   └── requirements.txt # Librairies Python requises
│
├── data/
│   └── sample.log       # Fichier de log généré automatiquement
│
├── output/
│   └── rapport.txt      # Résumé texte généré automatiquement
│
├── RAPPORT.ipynb        # Rapport Jupyter avec graphiques et analyse
└── README.md            # Ce fichier
```
<img width="945" height="276" alt="image" src="https://github.com/user-attachments/assets/78547d4b-d007-46d8-a40d-ceeca009fa1b" />

---

## 3. Exécution

### Étape 1 — Lancer le script Bash (collecte + analyse)

```bash
bash scripts/analyse.sh
```
<img width="945" height="215" alt="image" src="https://github.com/user-attachments/assets/dcbdfc22-414a-446a-aef0-a99e57b4fcd4" />

Ce script :
- Envoie une requête HTTP vers le site cible
- Mesure le temps de réponse
- Enregistre le code HTTP, le temps et la date dans `data/sample.log`
- Appelle automatiquement `scripts/analyse.py`

### Étape 2 — Lancer le script Python seul (optionnel)

```bash
python3 scripts/analyse.py data/sample.log
```

### Étape 3 — Consulter le rapport Jupyter

```bash
jupyter notebook RAPPORT.ipynb
```
<img width="945" height="215" alt="image" src="https://github.com/user-attachments/assets/4567896a-e1f2-4522-ac54-4cc3d119aad0" />

Ouvrir le fichier, puis : Kernel → Restart & Run All

<img width="945" height="215" alt="image" src="https://github.com/user-attachments/assets/f65ca5c8-016a-4e51-91a6-ca929aeb2c1d" />

---

## 4. Dépendances

- Bash (installé par défaut sur Linux/macOS)
- Python >= 3.8
- Modules Python (voir `scripts/requirements.txt`) :
  - `requests`
  - `matplotlib`
- Jupyter Notebook

### Installation des dépendances Python

```bash
pip3 install -r scripts/requirements.txt
```

---

## 5. Résultat attendu

| Fichier | Contenu |
|---|---|
| `data/sample.log` | Entrées horodatées : URL, code HTTP, temps de réponse |
| `output/rapport.txt` | Statistiques : moyenne, min, max, alertes (codes != 200) |
| `RAPPORT.ipynb` | Graphique de l'évolution du temps de réponse + analyse |

---

## 6. Exemple de sortie (output/rapport.txt)

```
=== Rapport de monitoring - 2025-01-01 ===
Site surveillé  : https://example.com
Vérifications   : 10
Code 200 (OK)   : 9
Erreurs         : 1
Temps moy.      : 245 ms
Temps min.      : 180 ms
Temps max.      : 890 ms
ALERTE          : 1 réponse avec code != 200
```

---

## 7. Bonnes pratiques

- Les scripts sont commentés ligne par ligne
- La structure de dossiers est respectée pour le script de test
- Le fichier `RAPPORT.ipynb` contient du texte explicatif en Markdown
  entre chaque cellule de code
- Toutes les dépendances sont listées dans `requirements.txt`

---

## 8. Auteur

Cours : INF1102  
Projet : 5 — Monitoring de site web
