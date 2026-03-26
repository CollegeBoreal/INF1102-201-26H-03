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

---

## ▶️ Exécution

```bash
sudo /entreprise/script_gestion.sh
⏰ Cron
0 2 * * * /entreprise/script_gestion.sh

➡️ Exécution automatique tous les jours à 2h

✅ Résultats
📂 Fichiers test

📜 Log

⏰ Cron

📦 Backup
---
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
