# 🧪 TP – Automatisation d’administration avec script Batch (Linux)

## 👤 Étudiant
**Nom : Abdou Karim NIANG**  
**ID : 300141858**

---

## 🎯 Objectif

Ce TP consiste à automatiser des tâches système sous Linux avec un script Bash :

- sauvegarde des données  
- création d’un utilisateur  
- test réseau  
- génération de logs  
- automatisation avec cron  

---

## 🏗️ Structure du projet

```bash
/entreprise/
├── data/
├── backup/
└── logs/

📂 Création de l’environnement
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs
📁 Fichiers de test
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt

```md
📜 Script
#!/bin/bash
...
▶️ Exécution
sudo /entreprise/script_gestion.sh

## 📸 Preuves

### 📌 Structure
![Structure](images/1_structure.png)

### 📌 Data
![Data](images/2_data.png)

### 📌 Script
![Script](images/3_script.png)

### 📌 Exécution
![Execution](images/4_execution.png)

### 📌 Backup
![Backup](images/5_backup.png)

### 📌 Utilisateur
![User](images/6_user.png)

### 📌 Log
![Log](images/7_log.png)

### 📌 Cron
![Cron](images/8_cron.png)