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
<img width="960" height="158" alt="image" src="https://github.com/user-attachments/assets/eee0fae1-f8bd-43ed-8c6a-dfa7fa84dcae" />


Création des fichiers test :

```bash
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```
<img width="1014" height="141" alt="image" src="https://github.com/user-attachments/assets/cb1a884f-25a5-4884-9911-ce745245548d" />


---

⚙️ Création du script

Création le fichier script :
```bash
sudo nano /entreprise/script_gestion.sh
```
<img width="890" height="69" alt="image" src="https://github.com/user-attachments/assets/ce4c79fb-3297-4a52-b53c-ddcf7682f2d3" />

<img width="1473" height="684" alt="image" src="https://github.com/user-attachments/assets/82ef3439-04fb-4371-95d5-39872c4abdf2" />

---

🔐 Rendre le script exécutable
```bash
sudo chmod +x /entreprise/script_gestion.sh
```
<img width="830" height="68" alt="image" src="https://github.com/user-attachments/assets/791034ca-eb66-40cb-b63a-ac2641a801fa" />


---
▶️ Test manuel

Exécuter le script :
```bash
sudo /entreprise/script_gestion.sh
```
<img width="709" height="69" alt="image" src="https://github.com/user-attachments/assets/a029a8b7-109b-42ba-ae11-58ba393b16d1" />


```bash
cat /etc/passwd | grep employe_temp
```
<img width="792" height="94" alt="image" src="https://github.com/user-attachments/assets/1d84028a-0f09-4c9c-9926-a5d105a5e2a4" />

* Le fichier log :

```bash
cat /entreprise/logs/log.txt
```
<img width="1577" height="1003" alt="image" src="https://github.com/user-attachments/assets/59b54edf-7fbd-4fc1-8311-b61625330e92" />

---

⏰ Planification avec Cron

Éditons la crontab :
```bash
sudo crontab -e
```
Ajouter :

```
0 2 * * * /entreprise/script_gestion.sh
```

➡ Exécution tous les jours à 2h00
<img width="1127" height="690" alt="image" src="https://github.com/user-attachments/assets/8e74188c-153c-4320-ac27-1166dd67c55a" />


---

🔍 Vérification de l’exécution
Vérifier le service cron :
```bash
systemctl status cron
```
<img width="1428" height="558" alt="image" src="https://github.com/user-attachments/assets/094dcab3-e982-4ba5-9179-473f2148b197" />


Consulter les journaux :

```bash
journalctl -u cron
```
<img width="1434" height="512" alt="image" src="https://github.com/user-attachments/assets/374bc309-261f-4e2c-ac1a-5418b23de8cc" />

ou

```bash
cat /var/log/syslog | grep CRON
```
<img width="1448" height="469" alt="image" src="https://github.com/user-attachments/assets/23ca60d7-b7e4-432a-9e14-6bfb8d8d3e84" />

---


📊 Résultat attendu

Après exécution automatique :

✔ Sauvegarde des fichiers effectuée

✔ Archive compressée générée

✔ Utilisateur temporaire créé

✔ Logs détaillés disponibles

✔ Exécution automatique quotidienne fonctionnelle
