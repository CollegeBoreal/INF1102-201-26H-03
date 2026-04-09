# 🚀 Automatisation DevOps avec PowerShell

> Projet étudiant réalisé dans le cadre du cours **INF1102** — Collège Boréal  
> Dossier : `6.PWSH/300150485`

---

## 📋 Description

Ce projet consiste à développer un script PowerShell permettant d'**automatiser des tâches DevOps** courantes dans un environnement Linux/VM. L'objectif est de démontrer la capacité à utiliser PowerShell comme outil d'automatisation cross-plateforme, tout en appliquant les bonnes pratiques de versionnement avec Git.

Le script génère automatiquement des rapports structurés (JSON et texte lisible) à partir des données collectées lors de l'exécution des tâches automatisées.

---

## 🎯 Objectifs

- Automatiser des tâches d'administration système avec PowerShell
- Générer des rapports de résultats dans plusieurs formats (`.json`, `.txt`)
- Appliquer les concepts DevOps vus en cours (automatisation, scripting, versionnement)
- Utiliser Git pour le suivi et la gestion du projet
- Travailler dans un environnement Linux/VM avec PowerShell Core

---

## 🛠️ Technologies utilisées

| Technologie | Description |
|-------------|-------------|
| ![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white) | Langage de scripting principal |
| ![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black) | Environnement d'exécution (VM) |
| ![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white) | Versionnement du code |
| JSON | Format de sortie structuré |
| Markdown | Documentation du projet |

---

## 📁 Structure du projet

```
6.PWSH/300150485/
│
├── 📄 devops_batch.ps1       # Script PowerShell principal
├── 📊 rapport.json           # Résultats générés (format structuré)
├── 📝 rapport.txt            # Résultats en version lisible
├── 🖼️ images/               # Captures d'écran et ressources visuelles
│   └── ...
└── 📖 README.md              # Documentation du projet
```

---

## ⚙️ Explication du script PowerShell

Le fichier `devops_batch.ps1` est le cœur du projet. Il effectue les opérations suivantes :

1. **Initialisation** — Définition des variables, chemins et paramètres de configuration
2. **Collecte de données** — Exécution des commandes système et récupération des informations
3. **Traitement** — Analyse et transformation des données collectées
4. **Génération des rapports** — Export des résultats vers `rapport.json` (structuré) et `rapport.txt` (lisible)
5. **Journalisation** — Affichage des étapes dans la console pour le suivi en temps réel

> 💡 Le script est conçu pour être modulaire et facilement extensible pour des tâches supplémentaires.

---

## ▶️ Instructions d'exécution

### Prérequis

- PowerShell Core 7+ installé (`pwsh`)
- Accès à un terminal Linux ou une machine virtuelle
- Git installé et dépôt cloné

### Étape 1 — Cloner le dépôt

```bash
git clone <URL_DU_DEPOT>
cd 6.PWSH/300150485
```

### Étape 2 — Vérifier la version de PowerShell

```bash
pwsh --version
```

### Étape 3 — Donner les permissions d'exécution (si nécessaire)

```bash
chmod +x devops_batch.ps1
```

### Étape 4 — Lancer le script

```bash
pwsh ./devops_batch.ps1
```

### Étape 5 — Consulter les résultats

```bash
# Voir le rapport texte
cat rapport.txt

# Voir le rapport JSON
cat rapport.json
```

---

## 📊 Résultats attendus

Après l'exécution du script, les fichiers suivants sont générés ou mis à jour :

- **`rapport.json`** — Fichier structuré contenant les résultats sous forme de paires clé/valeur, exploitable par d'autres outils ou scripts
- **`rapport.txt`** — Version lisible et formatée des mêmes résultats, idéale pour une lecture directe en terminal
- **Console** — Affichage en temps réel de la progression et des étapes complétées

---

## 👤 Auteur

**Nadir Fetis**  
Étudiant en Techniques de l'informatique  
📧 Collège Boréal  
🔗 [GitHub](https://github.com/)

---

## 🏫 Contexte académique

| Champ | Détail |
|-------|--------|
| Établissement | Collège Boréal |
| Cours | INF1102 — Introduction au DevOps |
| Session | 2024–2025 |
| Dossier de remise | `6.PWSH/300150485` |

---

## 📝 Notes

- Ce projet est réalisé à des fins **éducatives** dans le cadre du programme d'études du Collège Boréal.
- Toute reproduction ou utilisation à d'autres fins doit être faite avec l'accord de l'auteur.

---

<div align="center">
  <sub>Fait avec ❤️ par Nadir Fetis — Collège Boréal</sub>
</div>
