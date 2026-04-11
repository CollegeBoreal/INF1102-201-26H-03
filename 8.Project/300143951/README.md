# 🌍 Projet IDH Afrique — Tableau de bord du Développement Humain

> **Étudiant** : Frank Laurel  
> **ID Étudiant** : 300143951  
> **Cours** : Techniques des Systèmes Informatiques (TSI) — INF1102-201-26H-03  
> **Collège** : Collège Boréal — Campus Toronto  
> **Session** : Hiver 2025  
> **Source de données** : [World Bank Open Data API](https://data.worldbank.org/)
>http://vm300143951:8888/tree?token=753fd351a6e43a1f168b47bdd438f1c49934022bf775050d

---

## 📋 Table des matières

1. [Objectif du projet](#-objectif-du-projet)
2. [Pays et indicateurs analysés](#-pays-et-indicateurs-analysés)
3. [Architecture du projet](#-architecture-du-projet)
4. [Technologies utilisées](#-technologies-utilisées)
5. [Installation et exécution](#-installation-et-exécution)
6. [Déploiement Ansible](#-déploiement-ansible)
7. [Automatisation CRON](#-automatisation-cron)
8. [Rapport Jupyter](#-rapport-jupyter)
9. [Résultats et graphiques](#-résultats-et-graphiques)
10. [Difficultés rencontrées et solutions](#-difficultés-rencontrées-et-solutions)
11. [Compétences démontrées](#-compétences-démontrées)

---

## 🎯 Objectif du projet

Ce projet analyse les **indicateurs de développement humain** pour 8 pays d'Afrique subsaharienne, avec le **Cameroun** comme pays de référence — mon pays d'origine. Les données sont récupérées automatiquement via l'**API publique et gratuite de la Banque Mondiale**, traitées avec Python et Bash, visualisées dans un rapport Jupyter interactif, et déployées automatiquement sur une machine virtuelle Ubuntu via **Ansible**.

Le projet démontre la maîtrise de l'ensemble des modules du cours TSI :
Bash, Python, PowerShell, REGEX, CRON, Ansible, GitHub et Jupyter.

---

## 🌍 Pays et indicateurs analysés

### Pays étudiés

| Code | Pays | Rôle |
|---|---|---|
| CM | **Cameroun** | 🔴 Pays de référence (focus) |
| NG | Nigeria | Comparatif |
| ZA | Afrique du Sud | Comparatif |
| GH | Ghana | Comparatif |
| SN | Sénégal | Comparatif |
| KE | Kenya | Comparatif |
| CI | Côte d'Ivoire | Comparatif |
| ET | Éthiopie | Comparatif |

### Indicateurs World Bank

| Indicateur | Code API | Unité |
|---|---|---|
| PIB par habitant | `NY.GDP.PCAP.CD` | USD |
| Espérance de vie | `SP.DYN.LE00.IN` | Années |
| Mortalité infantile | `SH.DYN.MORT` | Pour 1 000 naissances |
| Taux d'alphabétisation | `SE.ADT.LITR.ZS` | % |
| Accès à l'électricité | `EG.ELC.ACCS.ZS` | % |
| Accès à Internet | `IT.NET.USER.ZS` | % |

---

## 🗂️ Architecture du projet

```
300143951/                          ← Répertoire racine (ID étudiant)
│
├── scripts/
│   ├── analyse.sh                  ← Script Bash principal (orchestration)
│   ├── analyse.py                  ← Script Python (API, REGEX, CSV, graphiques)
│   ├── analyse.ps1                 ← Script PowerShell (module PWSH)
│   └── requirements.txt            ← Dépendances Python
│
├── data/
│   └── raw/                        ← Données JSON + CSV (générés automatiquement)
│       ├── CM_NY_GDP_PCAP_CD.json
│       ├── PIB_par_habitant_USD.csv
│       └── ...
│
├── output/                         ← Livrables générés automatiquement
│   ├── rapport.txt                 ← Rapport texte
│   ├── graph_PIB_par_habitant_USD.png
│   ├── graph_Esperance_de_vie_ans.png
│   ├── graph_Mortalite_infantile_pour_1000.png
│   ├── graph_Taux_alphabetisation_pct.png
│   ├── graph_Acces_electricite_pct.png
│   ├── graph_Acces_internet_pct.png
│   ├── bar_*.png                   ← Graphiques comparatifs en barres
│   ├── heatmap_idh.png             ← Tableau de bord global
│   ├── execution.log               ← Journal d'exécution Bash
│   └── cron.log                    ← Journal CRON quotidien
│
├── ansible/
│   ├── inventory.ini               ← Inventaire de la VM cible
│   ├── playbook.yml                ← Playbook de déploiement complet
│   └── roles/                      ← Rôles Ansible (structure pro)
│
├── notebooks/                      ← Dossier pour notebooks supplémentaires
│
├── venv/                           ← Environnement Python virtuel (auto-créé)
│
├── .github/
│   └── workflows/
│       └── ci.yml                  ← Pipeline CI/CD GitHub Actions
│
├── RAPPORT.ipynb                   ← Rapport interactif Jupyter Notebook
└── README.md                       ← Ce fichier
```

---

## 🛠️ Technologies utilisées

| Technologie | Utilisation dans le projet |
|---|---|
| **Bash** | Orchestration, logging, gestion virtualenv, vérifications |
| **Python 3** | Appels API, nettoyage REGEX, export CSV, génération graphiques |
| **PowerShell** | Script alternatif Windows pour appels API |
| **REGEX** | Validation codes pays, années, valeurs numériques, nulles |
| **CRON** | Mise à jour automatique des données chaque jour à 06h00 |
| **Ansible** | Déploiement automatisé complet sur VM Ubuntu |
| **Jupyter Notebook** | Rapport interactif avec visualisations |
| **GitHub Actions** | CI/CD — tests automatiques à chaque push |
| **World Bank API** | Source de données officielle (gratuite, sans clé) |
| **matplotlib / seaborn** | Visualisations graphiques |
| **pandas** | Traitement et manipulation des données |

---

## 🚀 Installation et exécution

### Prérequis

- Python 3.8+
- Bash (Linux/macOS) ou WSL (Windows)
- Connexion Internet (pour l'API World Bank)

### Étape 1 — Cloner ou copier le projet

```bash


# via SCP depuis Windows vers VM
scp -i $HOME\.ssh\id_ed25519 -r C:\chemin\vers\300143951\ ubuntu@300143951:~/300143951
```

### Étape 2 — Créer l'environnement Python

```bash
# Installer venv 
sudo apt install python3-venv -y

# Créer et activer le virtualenv
python3 -m venv venv
source venv/bin/activate
```

### Étape 3 — Installer les dépendances

```bash
pip install -r scripts/requirements.txt
```

### Étape 4 — Rendre les scripts exécutables

```bash
chmod +x scripts/analyse.sh scripts/analyse.py
```

### Étape 5 — Lancer l'analyse

```bash
# Mode test (données simulées, sans appels API)
bash scripts/analyse.sh --dry-run

# Analyse complète avec vraies données API World Bank
bash scripts/analyse.sh
```

### Étape 6 — Script PowerShell (Windows)

```powershell
# Aperçu rapide
.\scripts\analyse.ps1

# Analyse complète via Python
.\scripts\analyse.ps1 -FullRun

# Mode test
.\scripts\analyse.ps1 -DryRun
```

---

## 🤖 Déploiement Ansible

Le déploiement sur la VM Ubuntu est entièrement automatisé via Ansible.

### Configuration de l'inventaire

Éditer `ansible/inventory.ini` :

```ini
[vm_ubuntu]
idh-vm ansible_host=10.7.237.206 ansible_user=ubuntu

[vm_ubuntu:vars]
ansible_python_interpreter=/usr/bin/python3
project_dir=/home/ubuntu/300143951
```

<img width="978" height="989" alt="execution script" src="https://github.com/user-attachments/assets/47d7e0c8-4d5a-4644-8f0a-97894c8e16e2" />

> ⚠️ **Note importante** : Ne pas spécifier `ansible_ssh_private_key_file`
> si la clé SSH par défaut (`~/.ssh/id_ed25519`) est déjà configurée.
> Ansible l'utilisera automatiquement.

### Tester la connexion SSH

```bash
# Depuis la machine physique (WSL)
ssh ubuntu@10.7.237.206

# Test Ansible (ping)
ansible -i ansible/inventory.ini vm_ubuntu -m ping
```

Résultat attendu :

```json
idh-vm | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

### Lancer le playbook complet

```bash
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
```<img width="1920" height="1020" alt="Screenshot 2026-04-11 123932" src="https://github.com/user-attachments/assets/1ec2cf0b-35c8-4d77-9734-a75a8905ee48" />


### Ce que le playbook automatise

| Tâche | Statut |
|---|---|
| Mise à jour APT | ✅ |
| Installation Python, Git, Jupyter | ✅ |
| Création de la structure de dossiers | ✅ |
| Copie des scripts sur la VM | ✅ |
| Création du virtualenv Python | ✅ |
| Installation des dépendances Python | ✅ |
| Configuration du CRON quotidien | ✅ |
| Lancement de l'analyse initiale | ✅ |
| Vérification du rapport généré | ✅ |

Résultat final du playbook :
```

<img width="1920" height="1020" alt="Screenshot 2026-04-11 152438" src="https://github.com/user-attachments/assets/f4062232-20f7-4dd8-8dbc-363633e7f0ae" />
```
PLAY RECAP
idh-vm : ok=19  changed=4  unreachable=0  failed=0  skipped=2
```

---

## ⏰ Automatisation CRON

Le CRON est configuré automatiquement par Ansible. Il relance l'analyse chaque jour à 06h00.

### Vérifier le CRON sur la VM

```bash
crontab -l
```

Résultat :
```
0 6 * * * cd /home/ubuntu/300143951 && source venv/bin/activate && bash scripts/analyse.sh >> output/cron.log 2>&1
```

### Consulter les logs CRON

```bash
cat ~/300143951/output/cron.log
```

---

## 📓 Rapport Jupyter

### Lancer Jupyter sur la VM

```bash
cd ~/300143951
source venv/bin/activate
jupyter notebook --no-browser --ip=0.0.0.0 --port=8888 --notebook-dir=/home/ubuntu/300143951
```

### Accéder depuis le navigateur (machine physique)

```
http://10.7.237.206:8888
```

<img width="1920" height="1020" alt="Screenshot 2026-04-11 162425" src="https://github.com/user-attachments/assets/736e9b8e-8135-4697-aa68-9418a2e9b87c" />


Pour s'authentifier sans mot de passe, récupérer le token :

```bash
jupyter server list
```

Copier l'URL complète avec token dans le navigateur, par exemple :
```
http://10.7.237.206:8888/?token=2752a4bec3e8d7e5d4a314df09d231906152589c73210a5f
```

### Exécuter le rapport

Dans Jupyter : **Kernel → Restart & Run All**

---

## 📊 Résultats et graphiques

Après exécution, les fichiers suivants sont générés dans `output/` :

| Fichier | Description |
|---|---|
| `rapport.txt` | Résumé texte complet avec classements par indicateur |
| `graph_PIB_par_habitant_USD.png` | Évolution du PIB par habitant (1990–2023) |
| `graph_Esperance_de_vie_ans.png` | Évolution de l'espérance de vie |
| `graph_Mortalite_infantile_pour_1000.png` | Évolution mortalité infantile |
| `graph_Taux_alphabetisation_pct.png` | Taux d'alphabétisation |
| `graph_Acces_electricite_pct.png` | Accès à l'électricité |
| `graph_Acces_internet_pct.png` | Accès à Internet |
| `bar_*.png` | Comparaisons récentes entre pays (barres) |
| `heatmap_idh.png` | Tableau de bord global normalisé |

---

> 📸 **[INSÉRER ICI]** : Capture d'écran du terminal montrant l'exécution réussie de `bash scripts/analyse.sh` avec les 48 indicateurs traités et le message ✅ ANALYSE COMPLÈTE TERMINÉE.

---

<img width="1546" height="1033" alt="heatmap_idh" src="https://github.com/user-attachments/assets/25a70a8d-a164-4bb3-8374-73083801977c" />


---

## 🔧 Difficultés rencontrées et solutions

### 1. Dossier imbriqué lors du transfert SCP

**Problème** : Après le transfert SCP, le projet s'est retrouvé dans
`~/300143951/300143951/` au lieu de `~/300143951/`.

**Solution** :
```bash
mv ~/300143951/300143951 ~/300143951_tmp
rm -r ~/300143951
mv ~/300143951_tmp ~/300143951
```

---

### 2. pip3 sans support de `--break-system-packages`

**Problème** : Sur Ubuntu 22.04, pip3 ne reconnaissait pas l'option
`--break-system-packages` (version trop ancienne).

**Solution** : Utilisation d'un virtualenv Python à la place :
```bash
sudo apt install python3-venv -y
python3 -m venv venv
source venv/bin/activate
pip install -r scripts/requirements.txt
```

---

### 3. Jupyter inaccessible sans token

**Problème** : Le navigateur demandait un mot de passe ou token pour accéder
au Notebook Jupyter.

**Solution** : Récupérer le token depuis la VM et l'insérer directement
dans l'URL du navigateur :
```bash
source venv/bin/activate
jupyter server list
# → copier l'URL complète avec ?token=...
```

---

### 4. Chemin BASE_DIR incorrect dans le Notebook

**Problème** : Le Notebook utilisait `os.path.abspath('..')` qui pointait
vers `/home/ubuntu/` au lieu de `/home/ubuntu/300143951/`, causant
l'erreur "Fichier manquant".

**Solution** :
```bash
sed -i "s|BASE_DIR   = os.path.abspath('..')|BASE_DIR   = '/home/ubuntu/300143951'|g" RAPPORT.ipynb
```

---

### 5. Ansible — clé SSH introuvable

**Problème** : Ansible échouait avec `no such identity: /home/ubuntu/.ssh/id_ed25519`
car la clé SSH n'existait pas dans la VM.

**Cause** : Ansible était lancé depuis la VM elle-même, alors que la clé
privée se trouve sur la machine physique (WSL).

**Solution** : Lancer Ansible depuis la machine physique (WSL), là où la
clé SSH existe. Supprimer aussi la ligne `ansible_ssh_private_key_file`
de l'inventaire pour que Ansible utilise la clé par défaut automatiquement.

```bash
# Depuis WSL (machine physique) — PAS depuis la VM
ansible -i ansible/inventory.ini vm_ubuntu -m ping
```

---

### 6. Mauvaise IP dans l'inventaire Ansible

**Problème** : L'inventaire contenait encore le placeholder `192.168.1.XXX`
au lieu de la vraie IP de la VM (`10.7.237.206`).

**Solution** :
```bash
sed -i 's/192.168.1.XXX/10.7.237.206/g' ansible/inventory.ini
sed -i 's/ansible_user=frank/ansible_user=ubuntu/g' ansible/inventory.ini
```

---

### 7. Playbook — utilisateur `frank` inexistant sur la VM

**Problème** : Le playbook original référençait l'utilisateur `frank` et
le chemin `/home/frank/`, mais la VM n'a que l'utilisateur `ubuntu`.

**Solution** : Remplacer toutes les occurrences de `frank` par `ubuntu`
et `/home/frank/projet-idh-afrique` par `/home/ubuntu/300143951` dans
le playbook.

---

### 8. Chemin doublé lors de l'appel Ansible

**Problème** : En étant dans le dossier `ansible/`, la commande
`ansible -i ansible/inventory.ini` créait un chemin doublé
`ansible/ansible/inventory.ini` introuvable.

**Solution** : Toujours lancer Ansible depuis la racine du projet :
```bash
cd ~/300143951
ansible -i ansible/inventory.ini vm_ubuntu -m ping
```

---

## 📚 Compétences démontrées

| Module du cours | Implémentation dans le projet |
|---|---|
| **Programmation** | `scripts/analyse.py` — appels API, traitement données, graphiques |
| **Systèmes** | VM Ubuntu 22.04 — déploiement, permissions, chemins |
| **IaC** | `Dockerfile` (bonus) + structure reproductible |
| **CRON** | Tâche planifiée quotidienne à 06h00 via crontab |
| **BATCH** | `scripts/analyse.sh` — orchestration complète avec logging |
| **PWSH** | `scripts/analyse.ps1` — appels API et délégation Python |
| **REGEX** | 4 expressions régulières pour validation et nettoyage des données |
| **Ansible** | Playbook complet (19 tâches, 0 erreur) — inventaire, déploiement |
| **GitHub** | Versionnage + CI GitHub Actions (test dry-run automatique) |
| **Jupyter** | Rapport interactif avec 5 sections et visualisations |

---

## 🔍 Fonctionnalités REGEX

```python
# Validation du code pays (ex: "CM", "NG")
REGEX_COUNTRY_CODE = re.compile(r'^[A-Z]{2}$')

# Validation de l'année (ex: "2022")
REGEX_YEAR = re.compile(r'^\d{4}$')

# Validation d'une valeur numérique (entier ou décimal)
REGEX_NUMERIC = re.compile(r'^-?\d+(\.\d+)?$')

# Détection des valeurs nulles / manquantes
REGEX_NULL_VALUES = re.compile(r'^(null|none|na|n/a|-)$', re.IGNORECASE)
```

---

## 📁 Livrables du projet

| Livrable | Chemin | Statut |
|---|---|---|
| Script Bash | `scripts/analyse.sh` | ✅ |
| Script Python | `scripts/analyse.py` | ✅ |
| Script PowerShell | `scripts/analyse.ps1` | ✅ |
| Rapport texte | `output/rapport.txt` | ✅ Généré automatiquement |
| Graphiques PNG | `output/graph_*.png` | ✅ 14 graphiques générés |
| Heatmap | `output/heatmap_idh.png` | ✅ |
| Notebook Jupyter | `RAPPORT.ipynb` | ✅ |
| Inventaire Ansible | `ansible/inventory.ini` | ✅ |
| Playbook Ansible | `ansible/playbook.yml` | ✅ ok=19, failed=0 |
| CI/CD | `.github/workflows/ci.yml` | ✅ |
| README | `README.md` | ✅ Ce fichier |

---

## 🌐 Informations de déploiement

| Paramètre | Valeur |
|---|---|
| **VM** | Ubuntu 22.04.5 LTS |
| **IP VM** | 10.7.237.206 |
| **Utilisateur VM** | ubuntu |
| **Répertoire projet** | `/home/ubuntu/300143951` |
| **Jupyter** | http://10.7.237.206:8888 |
| **CRON** | Tous les jours à 06h00 |
| **Machine physique** | Windows 11 + WSL |

---

## 📖 Dépendances Python

```
requests>=2.31.0      # Appels API World Bank
pandas>=2.0.0         # Manipulation des données
matplotlib>=3.7.0     # Graphiques
seaborn>=0.12.0       # Heatmap
plotly>=5.15.0        # Graphiques interactifs
jupyter>=1.0.0        # Notebook
nbformat>=5.9.0       # Format notebook
ipykernel>=6.25.0     # Kernel Jupyter
```

---

*Projet réalisé dans le cadre du cours TSI (INF1102) — Collège Boréal — Session Hiver 2025*  
*Frank Laurel | ID : 300143951*
