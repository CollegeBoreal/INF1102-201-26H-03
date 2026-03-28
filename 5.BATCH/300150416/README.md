# 🚀 TP CRONTAB4 — Automatisation avec Bash

## 📌 Description du projet

Ce projet consiste à concevoir un script Bash permettant d’automatiser des tâches d’administration système dans un environnement Linux.

L’objectif principal est de remplacer des actions manuelles répétitives par un processus automatisé, fiable et traçable.

---

## 🎯 Objectifs

* Automatiser des tâches système avec Bash
* Mettre en place un mécanisme de sauvegarde
* Gérer les utilisateurs Linux
* Générer des journaux d’exécution (logs)
* Planifier l’exécution automatique avec CRON

---

## ⚙️ Fonctionnalités du script

Le script `script_gestion.sh` réalise les opérations suivantes :

### 🔹 1. Vérification de la connectivité réseau

```bash
ping -c 4 8.8.8.8
```

Permet de vérifier que la machine a accès au réseau.

---

### 🔹 2. Sauvegarde des fichiers

```bash
cp -r /entreprise/data/* /entreprise/backup/
```

Copie tous les fichiers du dossier source vers un dossier de sauvegarde.

---

### 🔹 3. Création d’un utilisateur temporaire

```bash
useradd employe_temp
```

Crée un utilisateur système utilisé temporairement pour des opérations.

---

### 🔹 4. Compression des données

```bash
tar -czvf /entreprise/backup/backup_$(date +%F).tar.gz /entreprise/data
```

Archive les données dans un fichier compressé avec la date du jour.

---

### 🔹 5. Journalisation (Logging)

```bash
/entreprise/logs/log.txt
```

Toutes les opérations sont enregistrées dans un fichier log pour assurer la traçabilité.

---

## ▶️ Exécution manuelle

Pour exécuter le script manuellement :

```bash
sudo /entreprise/script_gestion.sh
```

---

## 📅 Planification automatique avec CRON

Le script est configuré pour s’exécuter automatiquement tous les jours à 2h du matin :

```bash
0 2 * * * /entreprise/script_gestion.sh
```

---

## 🔍 Vérification des résultats

### ✔️ Vérifier la sauvegarde

```bash
ls -l /entreprise/backup
```

### ✔️ Vérifier l’utilisateur

```bash
cat /etc/passwd | grep employe_temp
```

### ✔️ Vérifier les logs

```bash
cat /entreprise/logs/log.txt
```

---

## 📁 Structure du projet

```bash
TP-CRONTAB4/
│
├── README.md
├── script_gestion.sh
└── images/
```

---

## 📸 Captures d’écran

Le dossier `images/` contient les preuves d’exécution :

* 🔹 Exécution du script
* 🔹 Création du backup
* 🔹 Utilisateur créé
* 🔹 Fichier log
* 🔹 Configuration CRON

---

## ⚠️ Gestion des erreurs

### Permission refusée

```bash
chmod +x /entreprise/script_gestion.sh
```

### Script non exécuté

```bash
sudo /entreprise/script_gestion.sh
```

### Problème CRON

```bash
journalctl -u cron
```

---

## 🧠 Concepts utilisés

* Bash scripting
* Gestion des fichiers et répertoires
* Gestion des utilisateurs Linux
* Compression et archivage (`tar`)
* Planification des tâches (`cron`)
* Journalisation système

---

## ✅ Conclusion

Ce TP démontre l’importance de l’automatisation dans l’administration système.

Grâce à ce script :

* les tâches sont exécutées automatiquement
* les erreurs humaines sont réduites
* les opérations sont tracées et vérifiables

---

## 👨‍💻 Auteur

**Étudiant : 300150416**
Techniques des systèmes informatiques — Collège Boréal

