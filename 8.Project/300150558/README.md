- **Nom :** amira Sadouni
- **Numéro étudiant :** 300150558
- **Cours :** INF1102 — Scripting et automatisation
- **Session :** Hiver 2026

# 🌐 Projet 5 : Monitoring de Site Web

## 1. Objectif

Ce projet consiste à surveiller automatiquement la disponibilité d'un ou plusieurs sites web,
mesurer les temps de réponse HTTP, détecter les erreurs, et générer des rapports texte et
visuels à l'aide de scripts Bash/PowerShell et Python.

---

## 2. Structure du projet

```
300150558/
│
├── scripts/
│   ├── analyse.ps1      # Script PowerShell principal (collecte et planification)
│   ├── analyse.py       # Script Python (analyse des données + graphiques)
│   └── requirements.txt # Dépendances Python
│
├── data/
│   └── ping_log.csv     # Historique des mesures (généré automatiquement)
│
├── output/
│   └── rapport.txt      # Résumé texte des statuts et alertes
│
├── RAPPORT.ipynb        # Rapport Jupyter avec graphiques et analyse
└── README.md            # Ce fichier
```

---

## 3. Fonctionnement

### Étape 1 — Collecte (PowerShell)

Le script `analyse.ps1` envoie des requêtes HTTP aux URLs cibles et enregistre :
- L'URL testée
- Le code de statut HTTP (200, 404, 500…)
- Le temps de réponse en millisecondes
- L'horodatage (date et heure)

### Étape 2 — Analyse (Python)

Le script `analyse.py` lit le fichier CSV généré et produit :
- Un résumé des statuts (OK / erreur / timeout)
- Un graphique des temps de réponse dans le temps
- Une liste d'alertes si un site est lent ou indisponible

### Étape 3 — Rapport (Jupyter)

`RAPPORT.ipynb` présente l'analyse complète avec :
- Commentaires et explications
- Graphiques interactifs
- Conclusions sur la disponibilité des sites

---

## 4. Exécution

### Lancer la collecte PowerShell :
```powershell
.\scripts\analyse.ps1
```

### Lancer l'analyse Python seule :
```bash
python3 scripts/analyse.py data/ping_log.csv
```

### Ouvrir le rapport Jupyter :
```bash
jupyter notebook RAPPORT.ipynb
```

---

## 5. Dépendances

- **PowerShell** >= 5.1 (ou pwsh sur Linux/macOS)
- **Python** >= 3.8
- Modules Python (voir `requirements.txt`) :
  - `requests` — requêtes HTTP
  - `pandas` — traitement des données CSV
  - `matplotlib` — génération des graphiques
- **Jupyter Notebook** ou **Jupyter Lab**

Installation des dépendances Python :
```bash
pip install -r scripts/requirements.txt
```

---

## 6. Résultats attendus

| Fichier | Contenu |
|---|---|
| `data/ping_log.csv` | Historique brut des mesures (URL, statut, temps, date) |
| `output/rapport.txt` | Résumé lisible avec alertes et statuts |
| `RAPPORT.ipynb` | Analyse visuelle complète avec graphiques |

---

## 7. Exemple de sortie (`rapport.txt`)

```
=== Rapport de monitoring — 2025-04-16 08:00 ===

Site               Statut    Temps moyen   Alertes
https://example.com   ✅ OK      142 ms        —
https://monsite.ca    ⚠️ LENT    1843 ms       Temps > 1000 ms
https://autre.com     ❌ ERREUR  —             Code HTTP 503

Sites surveillés : 3 | OK : 1 | Alertes : 1 | Erreurs : 1
```

---

## 8. Bonnes pratiques appliquées

- Scripts commentés et lisibles
- Structure de dossiers respectée
- Données brutes séparées des résultats (`data/` vs `output/`)
- `RAPPORT.ipynb` contient du texte explicatif en plus des graphiques
- Gestion des erreurs (timeout, connexion refusée, code HTTP non-200)

---

<img width="532" height="271" alt="image" src="https://github.com/user-attachments/assets/41436a48-6d56-4d08-92ed-a28a50bebfd5" />
### Capture 1 : Structure du projet

Cette capture montre l’organisation des dossiers du projet.

On retrouve :
- le dossier scripts contenant les fichiers Python et PowerShell
- le dossier data contenant la liste des sites
- le dossier output contenant les résultats générés
- le fichier RAPPORT.ipynb et README.md

Cette structure respecte les consignes du projet.

<img width="638" height="512" alt="image" src="https://github.com/user-attachments/assets/2121d38b-ba88-4676-adf7-61628235ebd4" />
### Analyse du graphique : Temps de réponse des sites web

Ce graphique présente le temps de réponse de trois sites web : Google, GitHub et Collège Boréal.

On observe que :
- Le site **GitHub** a le temps de réponse le plus élevé, ce qui signifie qu’il est plus lent à répondre que les autres.
- Le site **Google** présente un temps de réponse moyen.
- Le site **Collège Boréal** est le plus rapide parmi les trois.

Ces différences peuvent s’expliquer par plusieurs facteurs :
- la charge des serveurs
- la distance réseau
- la complexité du site web

Ce graphique permet donc de comparer visuellement les performances des sites et d’identifier rapidement lequel est le plus rapide ou le plus lent.

<img width="577" height="516" alt="image" src="https://github.com/user-attachments/assets/721888ad-72cf-49d0-8d8b-bbb637cc6971" />
Ce graphique montre la variation des temps de réponse entre les sites. GitHub est le plus lent, tandis que le site du Collège Boréal est le plus rapide. La courbe permet de visualiser clairement les différences de performance.




