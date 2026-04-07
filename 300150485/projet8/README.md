# 📊 Analyse de Logs — Projet 8 (Bash + Python)

> Projet étudiant réalisé dans le cadre du cours **INF1102** — Collège Boréal  
> Dossier : `projet8/300150485`

---

## 📋 Description

Ce projet automatise l'analyse d'un fichier de logs serveur en combinant la puissance de **Bash** et de **Python 3**. Les scripts identifient les adresses IP les plus actives ainsi que les URLs les plus consultées, puis génèrent automatiquement un rapport de synthèse.

Un notebook Jupyter (`RAPPORT.ipynb`) accompagne le projet avec les captures d'écran et l'analyse visuelle des résultats.

---

## 🎯 Objectifs

- Analyser un fichier de logs avec des scripts Bash et Python
- Identifier les adresses IP les plus fréquentes
- Identifier les URLs les plus consultées
- Générer automatiquement un rapport de résultats (`rapport.txt`)
- Comparer l'approche Bash vs Python pour le traitement de logs

---

## 🛠️ Technologies utilisées

| Technologie | Rôle |
|-------------|------|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnubash&logoColor=white) | Script d'analyse principal |
| ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | Script d'analyse alternatif |
| ![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black) | Environnement d'exécution (VM Ubuntu) |
| ![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=jupyter&logoColor=white) | Rapport avec captures d'écran |
| ![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white) | Versionnement du projet |

---

## 📁 Structure du projet

```
projet8/
├── 📂 scripts/
│   ├── 🔧 analyse.sh          # Script Bash d'analyse des logs
│   └── 🐍 analyse.py          # Script Python d'analyse des logs
├── 📂 data/
│   └── 📋 sample.log          # Fichier de logs source
├── 📂 output/
│   └── 📝 rapport.txt         # Rapport généré automatiquement
├── 📓 RAPPORT.ipynb            # Notebook Jupyter avec captures d'écran
└── 📖 README.md                # Documentation du projet
```

---

## ⚙️ Fonctionnement des scripts

### 🔧 Script Bash — `scripts/analyse.sh`

- Lit le fichier `data/sample.log`
- Extrait et compte les adresses IP les plus fréquentes
- Extrait et compte les URLs les plus consultées
- Génère le fichier `output/rapport.txt`

### 🐍 Script Python — `scripts/analyse.py`

- Analyse le même fichier `data/sample.log`
- Utilise les structures de données Python pour le comptage
- Produit les mêmes résultats pour permettre la comparaison

---

## ▶️ Instructions d'exécution

### Prérequis

- Linux (VM Ubuntu ou équivalent)
- Python 3.8+
- Bash 5+

### Lancer le script Bash

```bash
bash scripts/analyse.sh
```

### Lancer le script Python

```bash
python3 scripts/analyse.py
```

### Consulter le rapport généré

```bash
cat output/rapport.txt
```

---

## 📊 Exemple de résultats

Après exécution, le fichier `output/rapport.txt` contient :

```
Top IP:
192.168.1.1 -> 2 fois
192.168.1.2 -> 2 fois

Top URLs:
/index.html -> 3 fois
```

---

## 📓 Rapport & Captures d'écran

Les captures d'écran et l'analyse détaillée des résultats sont disponibles dans le notebook :

```bash
jupyter notebook RAPPORT.ipynb
```

---

## ✅ Conclusion

Ce projet démontre l'utilisation combinée de **Bash** et **Python** pour automatiser l'analyse de fichiers de logs et générer des rapports structurés. Il met en évidence les forces de chaque langage dans un contexte DevOps réel.

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
| Projet | 8 — Analyse de logs Bash + Python |

---

<div align="center">
  <sub>Fait avec ❤️ par Nadir Fetis — Collège Boréal</sub>
</div>