#!/bin/bash
LOG="/entreprise/logs/log.txt"
DATE=$(date)
echo "===================================" >> $LOG
echo "Début exécution : $DATE" >> $LOG

# 1. Vérification réseau
echo "Test réseau..." >> $LOG
ping -c 4 8.8.8.8 >> $LOG 2>&1
if [ $? -ne 0 ]; then
   echo "ERREUR : Pas de connexion réseau" >> $LOG
else
   echo "Connexion réseau OK" >> $LOG
fi

# 2. Sauvegarde des fichiers
echo "Sauvegarde en cours..." >> $LOG
cp -r /entreprise/data/* /entreprise/backup/ >> $LOG 2>&1
if [ $? -ne 0 ]; then
   echo "ERREUR lors de la sauvegarde" >> $LOG
else
   echo "Sauvegarde réussie" >> $LOG
fi

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
echo "Compression en cours..." >> $LOG
tar -czf /entreprise/backup/backup_$(date +%F).tar.gz /entreprise/data >> $LOG 2>&1
if [ $? -ne 0 ]; then
   echo "ERREUR lors de la compression" >> $LOG
else
   echo "Archive créée avec succès" >> $LOG
fi

# 5. Nettoyage anciennes archives
echo "Nettoyage anciennes archives..." >> $LOG
find /entreprise/backup -name "*.tar.gz" -mtime +7 -delete >> $LOG 2>&1

# 6. Suppression utilisateur
sudo userdel -r employe_temp >> $LOG 2>&1
echo "Utilisateur supprimé." >> $LOG

echo "Fin exécution : $(date)" >> $LOG
echo "===================================" >> $LOG
