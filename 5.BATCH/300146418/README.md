- Distribution Linux : Ubuntu Server
- Accès sudo
- Terminal
- Service cron actif

---

## 📁 Structure utilisée

Avant exécution :

```text
/entreprise/
│
├── data/
│   ├── fichier1.txt
│   ├── fichier2.txt
│
├── backup/
│
└── logs/

Après exécution :

/entreprise/
│
├── data/
│   ├── fichier1.txt
│   ├── fichier2.txt
│
├── backup/
│   ├── fichier1.txt
│   ├── fichier2.txt
│   └── backup_YYYY-MM-DD.tar.gz
│
└── logs/
    └── log.txt
⚙️ Préparation de l’environnement

Les dossiers ont été créés avec :

sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs

Les fichiers de test ont été créés avec :

echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
📄 Script utilisé

Le script principal est :

/entreprise/script_gestion.sh

Contenu du script :

#!/bin/bash

LOG="/entreprise/logs/log.txt"
DATE=$(date)

echo "===================================" >> $LOG
echo "Début exécution : $DATE" >> $LOG

# 1. Vérification réseau
echo "Test réseau..." >> $LOG
ping -c 4 8.8.8.8 >> $LOG 2>&1

# 2. Sauvegarde des fichiers
echo "Sauvegarde en cours..." >> $LOG
cp -r /entreprise/data/* /entreprise/backup/ >> $LOG 2>&1

# 3. Création utilisateur temporaire
USER_TEMP="employe_temp"

if id "$USER_TEMP" &>/dev/null; then
    echo "Utilisateur existe déjà." >> $LOG
else
    sudo useradd $USER_TEMP
    echo "$USER_TEMP:Temp1234" | sudo chpasswd
    echo "Utilisateur créé." >> $LOG
fi

# 4. Compression archive
tar -czvf /entreprise/backup/backup_$(date +%F).tar.gz /entreprise/data >> $LOG 2>&1

echo "Fin exécution : $(date)" >> $LOG
echo "===================================" >> $LOG
▶️ Exécution manuelle

Le script a été exécuté manuellement avec :

sudo /entreprise/script_gestion.sh
✅ Vérifications réalisées
1. Vérification de la sauvegarde
ls /entreprise/backup

Résultat attendu :

fichier1.txt
fichier2.txt
backup_YYYY-MM-DD.tar.gz
2. Vérification du fichier log
cat /entreprise/logs/log.txt

Le fichier log contient :

Début exécution
Test réseau
Sauvegarde en cours
Création utilisateur
Compression archive
Fin exécution
3. Vérification de l’utilisateur temporaire
cat /etc/passwd | grep employe_temp

Résultat :

l’utilisateur employe_temp a bien été créé
⏰ Planification avec Cron

La tâche planifiée a été ajoutée avec :

sudo crontab -e

Ligne utilisée :

0 2 * * * /entreprise/script_gestion.sh

Cette ligne permet d’exécuter automatiquement le script tous les jours à 2h00.

🔍 Vérification de Cron
Vérifier que le service cron fonctionne
systemctl status cron
Vérifier la tâche planifiée
sudo crontab -l
Vérifier les journaux cron
journalctl -u cron

ou

cat /var/log/syslog | grep CRON
📌 Résultats obtenus

À la fin du TP :

Le test réseau fonctionne correctement
Les fichiers sont copiés dans /entreprise/backup
Une archive compressée est générée
Le fichier log enregistre toutes les opérations
L’utilisateur employe_temp est créé
L’exécution automatique avec cron est configurée
📸 Preuves

Les captures d’écran sont disponibles dans le dossier :

images/
🧠 Conclusion

Ce TP m’a permis de pratiquer :

l’écriture d’un script Bash structuré
la gestion de fichiers et de dossiers
la création d’utilisateurs sous Linux
la journalisation des opérations
la planification automatique avec cron
la vérification et le diagnostic des erreurs
