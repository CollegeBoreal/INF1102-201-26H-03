# 🔍 Analyse des Logs Nginx avec Regex — TP 7.REGEX

> Projet étudiant réalisé dans le cadre du cours **INF1102** — Collège Boréal  
> Dossier : `7.REGEX/300150485`

![Session](https://img.shields.io/badge/Session-Hiver%202026-blue?style=flat)
![Statut](https://img.shields.io/badge/Statut-Complété-success?style=flat)
![Langage](https://img.shields.io/badge/PowerShell%20%2B%20Python-Regex-purple?style=flat)

---

## 📋 Description

Ce projet consiste à analyser un fichier de logs du serveur web **Nginx** à l'aide d'**expressions régulières (Regex)**. L'analyse est réalisée en parallèle avec **PowerShell** et **Python** afin de comparer leurs approches pour l'extraction d'informations pertinentes et la génération de rapports automatiques horodatés.

---

## 🎯 Objectifs

- Utiliser les expressions régulières pour analyser des logs Nginx
- Extraire des informations clés : adresses IP, codes HTTP, pages visitées
- Générer un rapport automatique horodaté
- Comparer l'approche PowerShell vs Python pour le traitement de logs

---

## 🛠️ Technologies utilisées

| Technologie | Rôle |
|-------------|------|
| ![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white) | Script d'analyse principal |
| ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | Script d'analyse alternatif |
| Regex | Moteur d'extraction de données |
| ![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white) | Versionnement du projet |
| Nginx Logs | Fichier source analysé (`access.log`) |

---

## 📁 Structure du projet

```
7.REGEX/
└── 300150485/
    ├── 📄 analyse_nginx.ps1                     # Script PowerShell
    ├── 🐍 analyse_nginx.py                      # Script Python
    ├── 📋 access.log                            # Fichier de logs Nginx source
    ├── 📝 rapport_nginx_ps1_YYYY-MM-DD.txt      # Rapport généré par PowerShell
    ├── 📝 rapport_nginx_py_YYYY-MM-DD.txt       # Rapport généré par Python
    ├── 🖼️ images/                              # Captures d'écran des résultats
    └── 📖 README.md                             # Documentation du projet
```

---

## 🔎 Expressions régulières utilisées

Les scripts utilisent les patterns Regex suivants pour analyser les logs Nginx :

| Pattern Regex | Ce qu'il extrait |
|---------------|-----------------|
| `(\d+\.\d+\.\d+\.\d+)` | Adresse IP du client |
| `"(GET\|POST\|PUT\|DELETE) ([^\s]+)` | Méthode HTTP + URL demandée |
| `HTTP/\d\.\d" (\d{3})` | Code de statut HTTP (200, 404, 500...) |

### Exemple de ligne de log analysée

```
192.168.1.1 - - [06/Apr/2026:10:23:45 +0000] "GET /index.html HTTP/1.1" 200 512
```

Ce que les scripts extraient de cette ligne :
- **IP** : `192.168.1.1`
- **Page** : `/index.html`
- **Code HTTP** : `200`

---

## ⚙️ Fonctionnement des scripts

### 🔷 Script PowerShell — `analyse_nginx.ps1`

- Lit le fichier `access.log` ligne par ligne
- Applique des patterns Regex avec `-match` et `$Matches`
- Extrait les codes de statut HTTP (`200`, `404`, `500`, etc.)
- Identifie les erreurs et les classe par type
- Affiche les adresses IP les plus actives
- Génère un rapport texte horodaté `rapport_nginx_ps1_YYYY-MM-DD.txt`

### 🐍 Script Python — `analyse_nginx.py`

- Analyse les logs avec le module `re`
- Utilise `Counter` pour compter les occurrences
- Compte les requêtes par type et par code HTTP
- Identifie les pages les plus demandées
- Génère un rapport texte horodaté `rapport_nginx_py_YYYY-MM-DD.txt`

---

## ⚖️ Comparaison PowerShell vs Python

| Critère | PowerShell | Python |
|---------|-----------|--------|
| Syntaxe Regex | `-match`, `$Matches` | `re.findall()`, `re.match()` |
| Comptage | `Group-Object` | `Counter()` |
| Lisibilité | Moyenne | Élevée |
| Vitesse | Rapide | Très rapide |
| Idéal pour | Environnement Windows/Admin | Analyse de données |

---

## ▶️ Instructions d'exécution

### Prérequis

- PowerShell Core 7+ (`pwsh`)
- Python 3.8+
- Fichier `access.log` présent dans le dossier

### Lancer le script PowerShell

```powershell
pwsh analyse_nginx.ps1
```

### Lancer le script Python

```bash
python analyse_nginx.py
```

### Consulter les rapports générés

```bash
cat rapport_nginx_ps1_2026-04-06.txt
cat rapport_nginx_py_2026-04-06.txt
```

---

## 📊 Résultats attendus

| Donnée extraite | Description |
|----------------|-------------|
| 🌐 Adresses IP | IP les plus actives sur le serveur |
| 📄 Pages visitées | URLs et ressources les plus demandées |
| ⚠️ Erreurs HTTP | Analyse des `404`, `500` et autres erreurs |
| ✅ Requêtes réussies | Comptage des réponses `200 OK` |
| 📝 Rapport horodaté | Fichier `.txt` généré automatiquement avec la date |

### Exemple de rapport généré

```
===== RAPPORT D'ANALYSE NGINX =====
Date : 2026-04-06

Top 5 Adresses IP :
192.168.1.1  -> 45 requêtes
192.168.1.2  -> 32 requêtes

Top 5 Pages visitées :
/index.html  -> 120 fois
/contact     -> 87 fois

Codes HTTP :
200 OK       -> 380
404 Not Found -> 25
500 Error    -> 5
====================================
```

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
| TP | 7 — Analyse de logs Nginx avec Regex |
| Session | Hiver 2026 |
| Dossier de remise | `7.REGEX/300150485` |

---

<div align="center">
  <sub>Fait avec ❤️ par Nadir Fetis — Collège Boréal</sub>
</div>
