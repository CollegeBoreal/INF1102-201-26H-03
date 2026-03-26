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
/entreprise/
│
├── data/ # Fichiers source
├── backup/ # Sauvegardes et archives
└── logs/ # Fichier journal


---

## 📜 Description du script

Le script `script_gestion.sh` permet de :

1. Vérifier la connectivité réseau avec `ping`
2. Copier les fichiers du dossier `/entreprise/data` vers `/entreprise/backup`
3. Créer un utilisateur temporaire `employe_temp`
4. Compresser les données dans une archive `.tar.gz`
5. Enregistrer toutes les actions dans un fichier log

---

## ▶️ Exécution du script

```bash
sudo /entreprise/script_gestion.sh
⏰ Planification avec Cron
0 2 * * * /entreprise/script_gestion.sh

➡️ Le script s’exécute automatiquement chaque jour à 2h

✅ Résultats obtenus
📂 Création des fichiers test
<img width="900" height="92" alt="image" src="https://github.com/user-attachments/assets/d882ab6e-1f80-4137-a644-677abd4828e0" />


📜 Fichier log généré
<img width="900" height="557" alt="image" src="https://github.com/user-attachments/assets/1dca748f-b54d-4f0c-ab55-2142ba98d268" />


⏰ Configuration Cron
<img width="900" height="470" alt="image" src="https://github.com/user-attachments/assets/d4149556-cd23-46f0-9de8-c33a076ceed5" />


📦 Sauvegarde et archive
<img width="900" height="59" alt="image" src="https://github.com/user-attachments/assets/15711b65-00f2-4a5e-96ce-4c4d796f7439" />


🔍 Vérifications
✔️ Les fichiers sont copiés dans /entreprise/backup
✔️ Une archive .tar.gz est créée
✔️ L’utilisateur temporaire est ajouté
✔️ Le fichier log contient toutes les étapes
✔️ Le cron est configuré correctement
⚠️ Problèmes rencontrés
Erreur SSH : REMOTE HOST IDENTIFICATION HAS CHANGED
Accès refusé (mot de passe incorrect)
✅ Solutions
Suppression de l’ancienne clé SSH :
ssh-keygen -R 10.7.237.214
Reconnexion avec les bons identifiants
🧠 Compétences acquises
Script Bash
Gestion des fichiers Linux
Gestion des utilisateurs
Automatisation avec cron
Analyse des logs
Résolution des erreurs
🚀 Conclusion

Ce projet m’a permis de maîtriser l’automatisation des tâches système sous Linux avec Bash, ainsi que la gestion des sauvegardes, des utilisateurs et des logs dans un environnement professionnel.

## 📁 Structure des dossiers

