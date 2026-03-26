# 🖥️ TP - Script de gestion Linux (Bash)

## 👩‍💻 Réalisé par
**Nom :** Amel Zourane  
**Cours :** INF1102  
**Collège Boréal**

---

## 🎯 Objectif

Ce projet consiste à créer un script Bash permettant de :

- Sauvegarder des fichiers d’entreprise
- Tester la connectivité réseau
- Créer un utilisateur temporaire
- Générer un fichier de logs
- Automatiser l’exécution avec cron
- Vérifier le bon fonctionnement du script

---

## ⚙️ Environnement

- Ubuntu Server
- Accès sudo
- Terminal Linux
- Service cron actif

---

## 📁 Structure des dossiers


/entreprise/
│
├── data/
├── backup/
└── logs/


---

## 📜 Description du script

Le script `script_gestion.sh` permet de :

1. Vérifier la connectivité réseau avec `ping`
2. Copier les fichiers de `/entreprise/data` vers `/entreprise/backup`
3. Créer un utilisateur temporaire `employe_temp`
4. Compresser les données en `.tar.gz`
5. Générer un fichier log



## ✅ Résultats

### 📂 Fichiers test
<img width="900" height="92" alt="image" src="https://github.com/user-attachments/assets/57729027-f731-4433-8fd0-4d09bc62a750" />



---

### 📜 Log
<img width="900" height="557" alt="image" src="https://github.com/user-attachments/assets/ea353dad-9f75-4efe-b368-a660e18c7987" />


---

### ⏰ Cron
<img width="900" height="470" alt="image" src="https://github.com/user-attachments/assets/e59873d4-265d-4adc-bc0b-b567cfcb8494" />


---

### 📦 Backup
<img width="900" height="59" alt="image" src="https://github.com/user-attachments/assets/486533c0-8e60-4379-bf62-2f2bbf91d70c" />


---

## ▶️ Exécution

```bash
sudo /entreprise/script_gestion.sh
⏰ Cron
0 2 * * * /entreprise/script_gestion.sh

➡️ Exécution automatique tous les jours à 2h


🔍 Vérification
✔️ Fichiers copiés
✔️ Archive créée
✔️ Utilisateur créé
✔️ Logs générés
✔️ Cron fonctionnel
⚠️ Problèmes rencontrés
SSH error (clé changée)
Accès refusé
Solution
ssh-keygen -R 10.7.237.214
🚀 Conclusion

Ce projet m’a permis de comprendre l’automatisation des tâches sous Linux avec Bash, la gestion des utilisateurs et la planification avec cron.
