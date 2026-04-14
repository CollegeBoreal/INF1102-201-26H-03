
# 📘 README – Script de gestion automatisée sous Linux (Ubuntu)

## 🧾 1. Objectif du projet

Ce projet consiste à développer un script Bash sous Linux permettant d’automatiser plusieurs tâches administratives essentielles dans un environnement d’entreprise.

Les objectifs principaux sont :

* Sauvegarder des fichiers
* Tester la connectivité réseau
* Créer un utilisateur temporaire
* Générer un fichier journal (log)
* Automatiser l’exécution avec CRON
* Vérifier et diagnostiquer les erreurs

---

## 🖥 2. Environnement utilisé

* Système d’exploitation : Ubuntu Server
* Accès : Terminal avec privilèges sudo
* Outils : Bash, CRON, commandes Linux

---

## 📁 3. Structure du projet

Avant exécution :

```
/entreprise/
│
├── data/        # fichiers sources
├── backup/      # sauvegardes
└── logs/        # fichiers journaux
```

Après exécution :

```
/entreprise/
│
├── data/
├── backup/
│   ├── fichier1.txt
│   ├── fichier2.txt
│   └── backup_YYYY-MM-DD.tar.gz
│
└── logs/
    └── log.txt
```

---

## ⚙️ 4. Préparation de l’environnement

Création des dossiers :

```bash
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs
```

Création des fichiers de test :

```bash
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```

---

## 🧠 5. Script Bash

Le script est stocké dans :

```
/entreprise/script_gestion.sh
```

Fonctionnalités du script :

* Test réseau avec `ping`
* Copie des fichiers vers backup
* Création d’un utilisateur temporaire
* Compression des données
* Enregistrement des opérations dans un log

---

## ▶️ 6. Exécution du script

Rendre le script exécutable :

```bash
sudo chmod +x /entreprise/script_gestion.sh
```

Lancer le script :

```bash
sudo /entreprise/script_gestion.sh
```

---
<img width="857" height="572" alt="Capturegit" src="https://github.com/user-attachments/assets/a0ab8b72-21c0-4e05-827f-169ddb067204" />


## 🔍 7. Vérification des résultats

### ✔ Vérification des sauvegardes

```bash
ls /entreprise/backup
```

### ✔ Vérification de l’utilisateur

```bash
cat /etc/passwd | grep employe_temp
```

### ✔ Vérification du fichier log

```bash
cat /entreprise/logs/log.txt
```

---

## ⏰ 8. Planification automatique avec CRON

Modification de la crontab :

```bash
sudo crontab -e
```

Ajout de la tâche :

```bash
0 2 * * * /entreprise/script_gestion.sh
```

➡ Exécution automatique chaque jour à 02h00

---
<img width="1366" height="768" alt="crontab" src="https://github.com/user-attachments/assets/fcee8fdf-5f70-4c90-8f53-2ea075c6a966" />

## 🧪 9. Vérification du service CRON

```bash
systemctl status cron
```

Consulter les logs :

```bash
journalctl -u cron
```

ou

```bash
cat /var/log/syslog | grep CRON
```

---

<img width="688" height="525" alt="cron" src="https://github.com/user-attachments/assets/4acdae6c-6830-4cc8-b1ce-1d541aa0a954" />

## ⚠️ 10. Dépannage

| Problème                | Cause                 | Solution               |
| ----------------------- | --------------------- | ---------------------- |
| Permission denied       | Script non exécutable | chmod +x               |
| Script ne s’exécute pas | Mauvais chemin        | Utiliser chemin absolu |
| Archive vide            | Dossier data vide     | Vérifier contenu       |
| CRON ne fonctionne pas  | Service inactif       | systemctl start cron   |

---

## 🚀 11. Conclusion

Ce projet démontre la capacité à :

* Automatiser des tâches système avec Bash
* Gérer des fichiers et utilisateurs
* Mettre en place une planification automatique
* Diagnostiquer des problèmes système

Le script développé constitue une solution efficace pour la gestion automatisée dans un environnement Linux.

---

## 📚 12. Références

Documentation Linux officielle
Commandes Bash standard
Guide CRON (man cron)

---
