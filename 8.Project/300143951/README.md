# 🌍 Projet IDH Afrique — Tableau de bord du Développement Humain

> **Étudiant** : Frank Laurel | **ID** : 300143951  
> **Cours** : Techniques des Systèmes Informatiques (TSI)  
> **Collège** : Collège Boréal — Campus Toronto  
> **Session** : Hiver 2025  

---

## 🎯 Objectif

Ce projet analyse les **indicateurs de développement humain** pour 8 pays d'Afrique subsaharienne, avec le **Cameroun** comme pays de référence. Les données sont récupérées automatiquement via l'**API publique de la Banque Mondiale (World Bank)**, analysées avec Python et Bash, et visualisées dans un rapport Jupyter.

---

## 📊 Indicateurs analysés

| Indicateur | Code API World Bank | Unité |
|---|---|---|
| PIB par habitant | `NY.GDP.PCAP.CD` | USD |
| Espérance de vie | `SP.DYN.LE00.IN` | Années |
| Mortalité infantile | `SH.DYN.MORT` | Pour 1 000 naissances |
| Taux d'alphabétisation | `SE.ADT.LITR.ZS` | % |
| Accès à l'électricité | `EG.ELC.ACCS.ZS` | % |
| Accès à Internet | `IT.NET.USER.ZS` | % |

---

## 🗂️ Structure du projet

```
projet-idh-afrique/
│
├── scripts/
│   ├── analyse.sh          # Script Bash principal (orchestration)
│   ├── analyse.py          # Script Python (API, REGEX, graphiques)
│   ├── analyse.ps1         # Script PowerShell (module PWSH)
│   └── requirements.txt    # Dépendances Python
│
├── data/
│   └── raw/                # Données JSON et CSV (générés automatiquement)
│
├── output/
│   ├── rapport.txt         # Rapport texte (généré automatiquement)
│   ├── graph_*.png         # Graphiques d'évolution temporelle
│   ├── bar_*.png           # Graphiques comparatifs en barres
│   ├── heatmap_idh.png     # Tableau de bord global
│   └── execution.log       # Journal d'exécution
│
├── ansible/
│   ├── inventory.ini       # Inventaire de la VM cible
│   └── playbook.yml        # Playbook de déploiement complet
│
├── .github/
│   └── workflows/
│       └── ci.yml          # Pipeline CI/CD GitHub Actions
│
├── RAPPORT.ipynb           # Rapport interactif Jupyter Notebook
└── README.md               # Ce fichier
```

---

## 🚀 Exécution

### Prérequis
- Python 3.8+
- Bash (Linux/macOS) ou WSL (Windows)
- Connexion Internet (pour l'API World Bank)

### 1. Analyse complète (recommandée)
```bash
# Cloner le projet
git clone https://github.com/VOTRE_USERNAME/projet-idh-afrique.git
cd projet-idh-afrique

# Lancer l'analyse complète
bash scripts/analyse.sh
```

### 2. Mode test (sans appels API)
```bash
bash scripts/analyse.sh --dry-run
# ou directement :
python3 scripts/analyse.py --dry-run
```

### 3. Script PowerShell (Windows)
```powershell
# Aperçu rapide d'un indicateur
.\scripts\analyse.ps1

# Analyse complète via Python
.\scripts\analyse.ps1 -FullRun
```

### 4. Ouvrir le Notebook Jupyter
```bash
# Sur la machine locale
jupyter notebook RAPPORT.ipynb

# Sur la VM (accès depuis le navigateur de la machine physique)
jupyter notebook --no-browser --ip=0.0.0.0 --port=8888 RAPPORT.ipynb
# Puis ouvrir : http://IP_VM:8888
```

---

## 🤖 Déploiement Ansible (sur VM Ubuntu)

```bash
# 1. Modifier l'IP de votre VM dans ansible/inventory.ini
nano ansible/inventory.ini

# 2. Vérifier la connexion SSH à la VM
ansible -i ansible/inventory.ini vm_ubuntu -m ping

# 3. Lancer le déploiement complet
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml

# 4. Mode simulation (sans modifications)
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --check
```

Le playbook Ansible :
- Installe toutes les dépendances système
- Copie les scripts sur la VM
- Configure le CRON quotidien (06h00)
- Lance l'analyse initiale automatiquement

---

## ⏰ Automatisation CRON

Le CRON est configuré automatiquement par Ansible. Pour vérifier :
```bash
crontab -l
# → 0 6 * * * bash /home/frank/projet-idh-afrique/scripts/analyse.sh
```

---

## 🔍 Fonctionnalités REGEX implémentées

Le script Python utilise des expressions régulières pour :

```python
REGEX_COUNTRY_CODE = re.compile(r'^[A-Z]{2}$')        # Codes pays ISO
REGEX_YEAR         = re.compile(r'^\d{4}$')            # Années valides
REGEX_NUMERIC      = re.compile(r'^-?\d+(\.\d+)?$')   # Valeurs numériques
REGEX_NULL_VALUES  = re.compile(r'^(null|none|na|n/a|-)$', re.IGNORECASE)
```

---

## 📁 Livrables

| Livrable | Chemin | Description |
|---|---|---|
| Script Bash | `scripts/analyse.sh` | Orchestration principale |
| Script Python | `scripts/analyse.py` | Analyse + graphiques |
| Script PowerShell | `scripts/analyse.ps1` | Module PWSH |
| Rapport texte | `output/rapport.txt` | Généré automatiquement |
| Graphiques | `output/*.png` | Évolutions + comparaisons |
| Notebook | `RAPPORT.ipynb` | Rapport interactif |
| Ansible | `ansible/playbook.yml` | Déploiement VM |
| CI/CD | `.github/workflows/ci.yml` | Tests automatisés |

---

## 🛠️ Dépendances Python

```
requests>=2.31.0      # Appels API World Bank
pandas>=2.0.0         # Manipulation des données
matplotlib>=3.7.0     # Graphiques
seaborn>=0.12.0       # Heatmap
plotly>=5.15.0        # Graphiques interactifs
jupyter>=1.0.0        # Notebook
```

---

## 📝 Notes importantes

- L'API World Bank est **gratuite et sans clé API**
- Les données couvrent **jusqu'à 30 ans d'historique**
- Le CRON met à jour les données chaque jour à **06h00**
- Le script respecte les limites de l'API (`time.sleep(0.5)` entre les appels)

---

*Projet réalisé dans le cadre du cours TSI — Collège Boréal — Session Hiver 2025*
