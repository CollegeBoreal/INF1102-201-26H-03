# 🐧 Linux Automation Project
> Automatisation d'administration avec Bash et Cron

---

## 👨‍🎓 Informations étudiant

| Champ | Valeur |
|-------|--------|
| **Nom** | Smail Ikhlef |
| **Numéro étudiant** | 300146721 |
| **Cours** | Administration Linux |
| **TP** | Automatisation avec script Bash |

---

## 📌 Description du projet

Ce projet consiste à développer un script Bash permettant d'automatiser des tâches d'administration sous Linux. Le script réalise automatiquement plusieurs opérations :

- 📁 Sauvegarde des fichiers d'entreprise
- 🌐 Test de connectivité réseau
- 👤 Création d'un utilisateur temporaire
- 📋 Génération d'un journal d'exécution
- 🗜️ Compression des sauvegardes
- ⏰ Planification automatique avec cron

> Ce type de script est très utilisé en administration système pour automatiser la maintenance des serveurs.

---

## 🖥️ Environnement

| Élément | Valeur |
|---------|--------|
| OS | Ubuntu Linux |
| Shell | Bash |
| Service | Cron |
| Accès | `sudo` |

---

## 📂 Structure du projet

```
/entreprise
│
├── data/
│   ├── fichier1.txt
│   └── fichier2.txt
│
├── backup/
│   └── backup_YYYY-MM-DD.tar.gz
│
├── logs/
│   └── log.txt
│
└── script_gestion.sh
```

| Dossier | Rôle |
|---------|------|
| `data/` | Fichiers originaux |
| `backup/` | Sauvegardes compressées |
| `logs/` | Journaux d'exécution |
| `script_gestion.sh` | Script d'automatisation principal |

---

## ⚙️ Installation et configuration

### 1️⃣ Création des dossiers

```bash
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs
```

### 2️⃣ Création des fichiers test

```bash
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```

### 3️⃣ Création du script

```bash
sudo nano /entreprise/script_gestion.sh
```

---

## 📜 Script Bash

```bash
#!/bin/bash

LOG="/entreprise/logs/log.txt"
DATE=$(date)

echo "===================================" >> $LOG
echo "Début exécution : $DATE" >> $LOG

# Test réseau
echo "Test réseau..." >> $LOG
ping -c 4 8.8.8.8 >> $LOG 2>&1

# Sauvegarde
echo "Sauvegarde en cours..." >> $LOG
cp -r /entreprise/data/* /entreprise/backup/ >> $LOG 2>&1

# Création utilisateur
USER_TEMP="employe_temp"

if id "$USER_TEMP" &>/dev/null; then
    echo "Utilisateur existe déjà." >> $LOG
else
    sudo useradd $USER_TEMP
    echo "$USER_TEMP:Temp1234" | sudo chpasswd
    echo "Utilisateur créé." >> $LOG
fi

# Compression
tar -czvf /entreprise/backup/backup_$(date +%F).tar.gz /entreprise/data >> $LOG 2>&1

echo "Fin exécution : $(date)" >> $LOG
echo "===================================" >> $LOG
```

---

## 🔐 Permissions

Le script doit être rendu exécutable avant utilisation :

```bash
sudo chmod +x /entreprise/script_gestion.sh
```

---

## ▶️ Exécution du script

```bash
sudo /entreprise/script_gestion.sh
```

---

## 🔍 Vérification

### Vérifier les sauvegardes

```bash
ls -l /entreprise/backup
```

### Vérifier l'utilisateur créé

```bash
id employe_temp
```

### Vérifier le journal d'exécution

```bash
cat /entreprise/logs/log.txt
```

---

## ⏰ Automatisation avec Cron

### Modifier la crontab

```bash
sudo crontab -e
```

### Ajouter la règle suivante

```cron
0 2 * * * /entreprise/script_gestion.sh
```

### Signification de la règle cron

| Champ | Valeur | Signification |
|-------|--------|---------------|
| `0` | minute | À la minute 0 |
| `2` | heure | À 02h00 |
| `*` | jour du mois | Tous les jours |
| `*` | mois | Tous les mois |
| `*` | jour de la semaine | Tous les jours |

> ➡️ Le script sera exécuté **chaque jour à 02h00**.

---

## 🔎 Vérification du service Cron

```bash
# Vérifier le statut du service
systemctl status cron

# Consulter les logs cron
journalctl -u cron
```

---

## 📊 Architecture du fonctionnement

```
┌──────────────────────┐
│  /entreprise/data    │
│  (fichiers source)   │
└──────────┬───────────┘
           │ cp -r (sauvegarde)
           ▼
┌──────────────────────┐
│ /entreprise/backup   │
└──────────┬───────────┘
           │ tar -czvf (compression)
           ▼
┌────────────────────────────────┐
│ backup_YYYY-MM-DD.tar.gz       │
└────────────────────────────────┘

           +

┌──────────────────────┐
│  /entreprise/logs    │
│       log.txt        │
│ (toutes les étapes   │
│  sont journalisées)  │
└──────────────────────┘
```

---

## 🧠 Compétences acquises

À travers ce projet, j'ai appris à :

- ✅ Créer et utiliser un script Bash
- ✅ Automatiser des tâches système
- ✅ Gérer les utilisateurs Linux
- ✅ Sauvegarder et compresser des fichiers
- ✅ Analyser des logs système
- ✅ Utiliser `cron` pour planifier des scripts

---

## 🛠️ Troubleshooting

| Problème | Cause probable | Solution |
|----------|---------------|----------|
| `Permission denied` | Script non exécutable | `chmod +x script_gestion.sh` |
| Utilisateur non créé | Manque de privilèges | Lancer avec `sudo` |
| Archive vide | Mauvais chemin source | Vérifier `/entreprise/data` |
| Cron ne fonctionne pas | Service cron arrêté | `systemctl start cron` |

---