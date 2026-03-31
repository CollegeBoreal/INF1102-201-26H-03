\# 🧪 BATCH - 300141858



\## 🎯 Objectif



L’objectif de ce TP est de :



\- automatiser des tâches d’administration système sous Linux

\- sauvegarder un dossier d’entreprise

\- créer un utilisateur temporaire

\- tester la connectivité réseau

\- générer un fichier journal (log)

\- planifier l’exécution automatique avec `cron`

\- vérifier le bon fonctionnement et diagnostiquer les erreurs



\---



\## 📁 Structure utilisée



Le projet utilise la structure suivante :



```bash

/entreprise/

├── data/       # fichiers sources

├── backup/     # sauvegardes et archives

└── logs/       # journaux d’exécution



📂 Fichiers de test



Création des fichiers :



echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt

echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt



⚙️ Script utilisé

📜 script\_gestion.sh

\#!/bin/bash



LOG="/entreprise/logs/log.txt"

DATE=$(date)



echo "===================================" >> $LOG

echo "Début exécution : $DATE" >> $LOG



\# Test réseau

echo "Test réseau..." >> $LOG

ping -c 4 8.8.8.8 >> $LOG 2>\&1



\# Sauvegarde

echo "Sauvegarde en cours..." >> $LOG

cp -r /entreprise/data/\* /entreprise/backup/ >> $LOG 2>\&1



\# Création utilisateur

USER\_TEMP="employe\_temp"



if id "$USER\_TEMP" \&>/dev/null; then

&#x20;   echo "Utilisateur existe déjà." >> $LOG

else

&#x20;   sudo useradd $USER\_TEMP

&#x20;   echo "$USER\_TEMP:Temp1234" | sudo chpasswd

&#x20;   echo "Utilisateur créé." >> $LOG

fi



\# Compression

tar -czvf /entreprise/backup/backup\_$(date +%F).tar.gz /entreprise/data >> $LOG 2>\&1



echo "Fin exécution : $(date)" >> $LOG

echo "===================================" >> $LOG



▶️ Exécution du script

sudo /entreprise/script\_gestion.sh



🔍 Vérification

ls /entreprise/backup

cat /etc/passwd | grep employe\_temp

cat /entreprise/logs/log.txt

sudo crontab -l

systemctl status cron



📸 Preuves



\## 📸 Preuves



\### 📌 Structure créée

!\[Structure](images/1\_structure.png)



\---



\### 📌 Fichiers data

!\[Data](images/2\_data.png)



\---



\### 📌 Script Bash

!\[Script](images/3\_script.png)



\---



\### 📌 Exécution du script

!\[Execution](images/4\_execution.png)



\---



\### 📌 Backup et archive

!\[Backup](images/5\_backup.png)



\---



\### 📌 Utilisateur créé

!\[User](images/6\_user.png)



\---



\### 📌 Fichier log

!\[Log](images/7\_log.png)



\---



\### 📌 Cron configuré

!\[Cron](images/8\_cron.png)

