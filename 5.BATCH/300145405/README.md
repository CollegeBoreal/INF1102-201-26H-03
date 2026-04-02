\#300145405

## 👤 Étudiant

- Identifiant : **300145405**
- Nom: Elhadj Sadou Barry 
- Cours : Programmation système 
- Thème : **Script de Gestion Automatisée sous Linux (IaC)**
## 🎯 Objectif

Ce projet consiste à développer un script Batch (Bash) permettant d’automatiser plusieurs tâches administratives sous Linux :

📁 Sauvegarde des données d’une entreprise

👤 Création d’un utilisateur temporaire

🌐 Test de la connectivité réseau

📝 Génération d’un fichier de logs

⏰ Planification automatique avec cron

🔍 Vérification et diagnostic des exécutions

-----
## 🖥 Environnement requis

Distribution Linux (ex : Ubuntu Server)

Accès sudo

Terminal

Service cron actif

## 📁 Structure du projet

Création des dossiers nécessaires :
```bash
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs

```
<img width="704" height="130" alt="image" src="https://github.com/user-attachments/assets/6f068f95-bb81-4a39-aa86-dfa010e70fbe" />
Création des fichiers test :

```bash
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```
<img width="997" height="93" alt="image" src="https://github.com/user-attachments/assets/c476c4c6-b114-462b-b06d-01988422e9dd" />

## ▶️ Test manuel

```bash
cat /etc/passwd | grep employe_temp
```

<img width="743" height="81" alt="image" src="https://github.com/user-attachments/assets/3e4f9ed1-9f2c-4332-948a-7c2b1b0dce37" />

<img width="1492" height="751" alt="image" src="https://github.com/user-attachments/assets/e727c245-0b09-44ac-abea-03805653d392" />

<img width="1443" height="591" alt="image" src="https://github.com/user-attachments/assets/c2a9e68b-6485-422d-a399-675b6a4d68c6" />



