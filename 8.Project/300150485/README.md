# 📊 Analyse de Logs — Projet 8 (PowerShell + Python)

> Projet étudiant réalisé dans le cadre du cours **INF1102** — Collège Boréal  
> Dossier : `projet8/300150485`

---

## 📋 Description

Ce projet automatise l'analyse d'un fichier de logs serveur en combinant la puissance de **PowerShell** et de **Python 3**. Les scripts identifient les adresses IP les plus actives ainsi que les URLs les plus consultées, puis génèrent automatiquement un rapport de synthèse.

Un notebook Jupyter (`RAPPORT.ipynb`) accompagne le projet avec les captures d'écran et l'analyse visuelle des résultats.

---

## 🎯 Objectifs

- Analyser un fichier de logs avec des scripts PowerShell et Python
- Identifier les adresses IP les plus fréquentes
- Identifier les URLs les plus consultées
- Générer automatiquement un rapport de résultats (`rapport.txt`)
- Comparer l'approche PowerShell vs Python pour le traitement de logs

---

## 🛠️ Technologies utilisées

| Technologie | Rôle |
|-------------|------|
| ![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white) | Script d'analyse principal |
| ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | Script d'analyse alternatif |
| ![Windows](https://img.shields.io/badge/Windows-0078D6?style=flat&logo=windows&logoColor=white) | Environnement d'exécution |
| ![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=jupyter&logoColor=white) | Rapport avec captures d'écran |
| ![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white) | Versionnement du projet |

---

## 📁 Structure du projet

```
projet8/
├── 📂 scripts/
│   ├── 💻 analyse.ps1        # Script PowerShell d'analyse des logs
│   └── 🐍 analyse.py         # Script Python d'analyse des logs
├── 📂 data/
│   └── 📋 sample.log         # Fichier de logs source
├── 📂 output/
│   └── 📝 rapport.txt        # Rapport généré automatiquement
├── 📂 images/
│   └── 📊 graphique.png      # Graphique généré
├── 📓 RAPPORT.ipynb           # Notebook Jupyter avec résultats
└── 📖 README.md               # Documentation du projet
```

---

## ⚙️ Fonctionnement des scripts

### 💻 Script PowerShell — `scripts/analyse.ps1`

- Lit le fichier `data/sample.log`
- Lance le script Python
- Génère le fichier `output/rapport.txt`

```powershell
powershell -ExecutionPolicy Bypass -File scripts\analyse.ps1
```

### 🐍 Script Python — `scripts/analyse.py`

- Analyse le fichier `data/sample.log`
- Extrait les IP et URLs
- Compte les occurrences avec `Counter`
- Génère le rapport et le graphique

```bash
python scripts\analyse.py data\sample.log
```

---

## 📊 Résultats attendus

| Résultat | Description |
|----------|-------------|
| 🌐 IP fréquentes | Adresses IP les plus actives détectées |
| 📄 URLs consultées | Pages les plus demandées identifiées |
| 📝 `output/rapport.txt` | Rapport généré automatiquement |
| 📊 `images/graphique.png` | Graphique de visualisation généré |

---

## 📓 Rapport & Visualisation

Le notebook `RAPPORT.ipynb` contient :

- Analyse complète des résultats
- Affichage et interprétation des données
- Visualisation du graphique

```bash
jupyter notebook RAPPORT.ipynb
```

---

## ✅ Conclusion

Ce projet démontre :

- L'automatisation avec PowerShell et Python
- L'analyse de données issues de logs serveur
- La génération de rapports et visualisations

> Utilisable en administration système et cybersécurité 🔐

---

## 👤 Auteur

**Nadir Fetis**  
Étudiant en Techniques de l'informatique — Collège Boréal

---

## 🏫 Contexte académique

| Champ | Détail |
|-------|--------|
| Établissement | Collège Boréal |
| Cours | INF1102 — Introduction au DevOps |
| Projet | 8 — Analyse de logs PowerShell + Python |

---

<div align="center">
  <sub>Fait avec ❤️ par Nadir Fetis — Collège Boréal</sub>
</div>
