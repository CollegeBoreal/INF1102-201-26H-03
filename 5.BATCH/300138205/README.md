## 👤 Étudiant

- Identifiant : **300138205**
- Nom: Taylor
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

Créer des fichiers test :

```bash
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```

---

⚙️ Création du script

Créer le fichier script :
```bash
sudo nano /entreprise/script_gestion.sh
```

---

🔐 Rendre le script exécutable
```bash
sudo chmod +x /entreprise/script_gestion.sh
```

---
▶️ Test manuel

Exécuter le script :
```bash
sudo /entreprise/script_gestion.sh
```

Vérifier :

* Les fichiers copiés dans `/entreprise/backup`
* L’archive `.tar.gz`
* L’utilisateur créé :

```bash
cat /etc/passwd | grep employe_temp
```
* Le fichier log :

```bash
cat /entreprise/logs/log.txt
```

---

⏰ Planification avec Cron

Éditer la crontab :
```bash
sudo crontab -e
```

Ajouter :

```
0 2 * * * /entreprise/script_gestion.sh
```

➡ Exécution tous les jours à 2h00

---

🔍 Vérification de l’exécution
Vérifier le service cron :
```bash
systemctl status cron
```

Consulter les journaux :

```bash
journalctl -u cron
```

ou

```bash
cat /var/log/syslog | grep CRON
```

---


📊 Résultat attendu

Après exécution automatique :

✔ Sauvegarde des fichiers effectuée

✔ Archive compressée générée

✔ Utilisateur temporaire créé

✔ Logs détaillés disponibles

✔ Exécution automatique quotidienne fonctionnelle
