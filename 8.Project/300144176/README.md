## 👤 Étudiant

# Projet 1 — Suivi de Météo Quotidienne

**Cours :** Scripting PowerShell + Python  
**API utilisée :** [Weatherstack](https://weatherstack.com/) (plan gratuit)  
## Structure du projet

```
300144176/
│
├── scripts/<img width="949" height="377" alt="Screenshot 2026-04-08 153601" src="https://github.com/user-attachments/assets/81413fac-55f3-43a4-ad24-f2ab8ad1bb83" />

│   ├── analyse.ps1       # Script PowerShell : appel API + lancement Python
│   └── analyse.py        # Script Python : analyse + graphiques + rapport texte
│
├── data/
│   └── meteo.json        # Données JSON récupérées par l'API (généré automatiquement)
│
├── output/
│   ├── rapport.txt          # Rapport texte généré automatiquement
│   ├── meteo.png            # Graphique en barres (métriques globales)
│   └── meteo_details.png    # Graphique détaillé (température vs ressenti + humidité)
│
├── RAPPORT.ipynb         # Rapport Jupyter avec visualisations et analyse
└── README.md             # Ce fichier
```

---


### Dépendances Python
```powershell
conda install matplotlib -y
```
ou
```powershell
pip install matplotlib
```

### Environnement
- Windows 10/11 avec PowerShell
- Python 3.8+ (Miniforge / Anaconda recommandé)
- Jupyter Notebook ou Jupyter Lab

---

## Exécution

### Étape 1 — Se placer à la racine du projet
```powershell
cd 300144176
```

### Étape 2 — Lancer le script principal
```powershell
.\scripts\analyse.ps1
```

Cela va :
1. Appeler l'API Weatherstack et sauvegarder `data\meteo.json`
2. Lancer `analyse.py` pour générer le rapport et les graphiques

### Étape 3 — Ouvrir le rapport Jupyter
```powershell
jupyter notebook RAPPORT.ipynb
```

---

## Résultats attendus

| Fichier | Contenu |
|---|---|
| `data\meteo.json` | Données brutes retournées par l'API |
| `output\rapport.txt` | Résumé texte : température, humidité, vent... |
| `output\meteo.png` | Graphique en barres des métriques principales |
| `output\meteo_details.png` | Graphique température vs ressenti + humidité/nuages/UV |
| `RAPPORT.ipynb` | Analyse complète avec graphiques et conclusion |

---

## Données récupérées

| Métrique | Description |
|---|---|
| Température | Température actuelle en °C |
| Ressenti | Température ressentie en °C |
| Humidité | Taux d'humidité en % |
| Vent | Vitesse en km/h et direction |
| Nuages | Couverture nuageuse en % |
| Visibilité | Distance de visibilité en km |
| Pression | Pression atmosphérique en hPa |
| Indice UV | Indice de rayonnement ultraviolet |
| Conditions | Description textuelle (ex: Sunny, Cloudy...) |

---

## Dépannage

| Problème | Solution |
|---|---|
| `python3` introuvable | Utiliser `python` à la place (Windows) |
| `ModuleNotFoundError: matplotlib` | Lancer `conda install matplotlib -y` |
| Erreur encodage JSON (UTF-8 BOM) | Le fichier `analyse.py` utilise `utf-8-sig` |
| Erreur chemin introuvable | Toujours lancer depuis le dossier `300144176\` |

---

## Auteur

Étudiant : *(DIABATE AWA ODENDO)*  
Cours : INF1102  
Session : Hiver 2026
