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
📜 Script
#!/bin/bash
...
▶️ Exécution
sudo /entreprise/script_gestion.sh
📸 Preuves
📌 Structure
<p align="center"> <img src="images/1_structure.png" width="600"> </p>
📌 Data
<p align="center"> <img src="images/2_data.png" width="600"> </p>
📌 Script
<p align="center"> <img src="images/3_script.png" width="600"> </p>
📌 Exécution
<p align="center"> <img src="images/4_execution.png" width="600"> </p>
📌 Backup
<p align="center"> <img src="images/5_backup.png" width="600"> </p>
📌 Utilisateur
<p align="center"> <img src="images/6_user.png" width="600"> </p>
📌 Log
<p align="center"> <img src="images/7_log.png" width="600"> </p>
📌 Cron
<p align="center"> <img src="images/8_cron.png" width="600"> </p>