# 🧪 TP – Automatisation d’administration avec script Bash

**Nom :** Zakaria Djellouli  
**ID :** 300150433  

---

## 🎯 Objectif

Ce TP consiste à créer un script Bash sous Linux permettant d’automatiser plusieurs tâches d’administration système :

- Sauvegarde des fichiers
- Test de connectivité réseau
- Création d’un utilisateur temporaire
- Génération de logs
- Compression des données
- Planification avec cron

---

## 🏗️ Structure du projet


300150433/
├── script_gestion.sh
├── README.md
└── images/


---

## ⚙️ Étapes réalisées

### 1️⃣ Préparation de l’environnement

Création des dossiers :
```bash
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs

Création des fichiers :

echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
2️⃣ Script Bash

Le script permet :

Tester la connexion réseau (ping)

Copier les fichiers

Créer un utilisateur temporaire

Générer un log

Créer une archive .tar.gz

Exécution :

sudo /entreprise/script_gestion.sh
3️⃣ Planification avec cron
sudo crontab -e

Ajout :

0 2 * * * /entreprise/script_gestion.sh
---
📜 Commandes utilisées (Résumé)
Commande	Description
mkdir -p	Créer des dossiers
tee	Écrire dans un fichier avec sudo
cp -r	Copier des fichiers
ping	Tester le réseau
useradd	Créer utilisateur
chpasswd	Définir mot de passe
tar -czvf	Créer archive
chmod +x	Rendre script exécutable
crontab -e	Planifier tâches
cat	Lire fichier
grep	Rechercher texte
---
🔹 Création des fichiers
<img width="734" height="74" alt="1" src="https://github.com/user-attachments/assets/b72af31b-65b6-4123-9f0f-764e58b1402f" />

🔹 Script
<img width="966" height="639" alt="capture script gestion " src="https://github.com/user-attachments/assets/b5783612-87e8-4307-8953-47bff2a403ac" />

🔹 Exécution + logs
<img width="623" height="439" alt="3" src="https://github.com/user-attachments/assets/cf50c3c9-3d4c-4597-b607-5e06b426e9dd" />

🔹 Cron
<img width="880" height="539" alt="capture crontab" src="https://github.com/user-attachments/assets/e3ab3285-64f2-4957-b0b1-a3422c65825a" />

🔹 Résultat backup
<img width="484" height="45" alt="2" src="https://github.com/user-attachments/assets/c9ba72bf-5704-4740-b658-c6bc7b04a58e" />


✅ Résultat final

Après exécution :

✔ Les fichiers sont copiés dans /entreprise/backup

✔ Une archive .tar.gz est créée

✔ Un utilisateur temporaire est créé

✔ Un fichier log est généré

✔ Le script est automatisé avec cron
