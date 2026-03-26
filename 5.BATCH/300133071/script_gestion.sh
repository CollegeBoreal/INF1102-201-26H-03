#!/bin/bash

# ==============================
# VARIABLES
# ==============================

LOG="/entreprise/logs/log.txt"
DATA="/entreprise/data"
BACKUP="/entreprise/backup"
USER_TEMP="employe_temp"
DATE=$(date)

# ==============================
# DEBUT DU SCRIPT
# ==============================

echo "===================================" >> $LOG
echo "Début exécution : $DATE" >> $LOG

# ==============================
# 1. Vérification réseau
# ==============================

echo "Test réseau..." >> $LOG

if ping -c 4 8.8.8.8 > /dev/null 2>&1
then
    echo "Connexion Internet OK" >> $LOG
else
    echo "ERREUR : Pas de connexion réseau" >> $LOG
fi

# ==============================
# 2. Vérification dossiers
# ==============================

echo "Vérification des dossiers..." >> $LOG

if [ ! -d "$DATA" ]; then
    echo "ERREUR : dossier DATA introuvable" >> $LOG
    exit 1
fi

if [ ! -d "$BACKUP" ]; then
    echo "Dossier backup inexistant, création..." >> $LOG
    mkdir -p $BACKUP
fi

# ==============================
# 3. Sauvegarde des fichiers
# ==============================

echo "Sauvegarde en cours..." >> $LOG
cp -r $DATA/* $BACKUP/ >> $LOG 2>&1

if [ $? -eq 0 ]; then
    echo "Sauvegarde terminée avec succès." >> $LOG
else
    echo "ERREUR lors de la sauvegarde." >> $LOG
fi

# ==============================
# 4. Création utilisateur temporaire
# ==============================

echo "Vérification utilisateur temporaire..." >> $LOG

if id "$USER_TEMP" &>/dev/null
then
    echo "Utilisateur $USER_TEMP existe déjà." >> $LOG
else
    useradd $USER_TEMP
    echo "$USER_TEMP:Temp1234" | chpasswd
    echo "Utilisateur $USER_TEMP créé." >> $LOG
fi

# ==============================
# 5. Compression archive
# ==============================

echo "Compression des données..." >> $LOG

tar -czf $BACKUP/backup_$(date +%F).tar.gz $DATA >> $LOG 2>&1

if [ $? -eq 0 ]; then
    echo "Archive créée avec succès." >> $LOG
else
    echo "ERREUR lors de la compression." >> $LOG
fi

# ==============================
# 6. Nettoyage anciennes archives (7 jours)
# ==============================

echo "Nettoyage anciennes sauvegardes..." >> $LOG
find $BACKUP -name "*.tar.gz" -mtime +7 -delete >> $LOG 2>&1

# ==============================
# 7. Fin du script
# ==============================

echo "Fin exécution : $(date)" >> $LOG
echo "===================================" >> $LOG
