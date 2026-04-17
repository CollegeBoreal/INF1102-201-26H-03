## TP Automatisation d’administration avec script Bash (Linux)

Informations de l’étudiant

Nom et Prénoms:Miri nour

Numéro étudiant: 300138573

Programme : Techniques des systèmes informatiques

Cours : INF 1102-201 – Programmation de systèmes

Professeur : Brice Robert


## Objectif
Ce travail pratique vise à automatiser des tâches d’administration sous Linux à l’aide d’un script Bash.

Les objectifs sont les suivants :

Sauvegarder un dossier d’entreprise
Créer un utilisateur temporaire
Tester la connectivité réseau
Générer un fichier journal (log)
Planifier l’exécution avec cron
Vérifier l’exécution et diagnostiquer les erreurs
Environnement requis
Distribution Linux (Ubuntu Server recommandé)
Accès administrateur (sudo)
Terminal
Service cron actif
Connexion au serveur Linux
Pour accéder au serveur Ubuntu, j’ai utilisé une connexion SSH avec une clé privée.

Commande utilisée

ssh -i ~/.ssh/ma_cle.pk \
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/tmp/ssh_known_hosts_empty \
ubuntu@10.7.237.197

<img width="1482" height="762" alt="image0" src="https://github.com/user-attachments/assets/8767f274-df59-482d-8677-11e0f838372f" />


PARTIE 1 – Préparation de l’environnement
Étape 1 : Création de la structure
Commande :

```bash
sudo mkdir -p /entreprise/data

sudo mkdir -p /entreprise/backup

sudo mkdir -p /entreprise/logs
```

Pour verifier, il faut taper :

```bash
ls -R /entreprise
```

<img width="1482" height="217" alt="batch111" src="https://github.com/user-attachments/assets/bffe128f-3ac9-4282-a357-d01dc5ff4cae" />

**Explication**: L’option -p permet de créer les dossiers parents si nécessaire.

Création de fichiers de test

## Commande :

```bash
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt

echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```

## Pour verifier

```bash
ls /entreprise/data
```

<img width="1483" height="217" alt="batch112" src="https://github.com/user-attachments/assets/d60be29d-afc2-4b89-8bb3-4490e2b9a738" />

## Résultat attendu :

fichier1.txt
fichier2.txt

**Explication** : La commande tee permet d’écrire dans un fichier avec les droits administrateur.


**PARTIE 2** – Création du script Bash

## Étape 3 : Création du script

 ##Commande :

```bash
sudo nano /entreprise/script_gestion.sh
```

Contenu complet du script dans l’éditeur nano

```bash

```

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
---

### Code du script

```bash
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
Explication : Ce script permet :

de tester la connectivité réseau
de sauvegarder les fichiers
de créer un utilisateur temporaire
de compresser les données
de journaliser toutes les opérations
PARTIE 3 – Rendre le script exécutable
Commande :

sudo chmod +x /entreprise/script_gestion.sh
image6
Pour verifier il faut taper:

ls -l /entreprise
image7
Résultat attendu : Le script possède les permissions d’exécution.

PARTIE 4 – Test manuel
Exécution du script
sudo /entreprise/script_gestion.sh
image8
Exécution dans le terminal
Vérifications
1. Vérification de la sauvegarde
ls /entreprise/backup
image9
Résultat attendu :

backup_2026-03-18.tar.gz fichier1.txt fichier2.txt

2. Vérification de l’utilisateur
cat /etc/passwd | grep employe_temp
image10
Résultat attendu : L’utilisateur apparaît dans le système.

3. Vérification du log
cat /entreprise/logs/log.txt
image11
Résultat attendu :

Début exécution : ...
Test réseau...
Sauvegarde en cours...
Utilisateur créé.
Fin exécution : ...
Explication : Le fichier log enregistre toutes les actions exécutées.

PARTIE 5 – Planification avec cron
Étape 5 : Configuration
sudo crontab -e
image12 0
Ajouter :

0 2 * * * /entreprise/script_gestion.sh
image12
ligne ajoutée dans la crontab
Explication : Exécution automatique tous les jours à 02h00.

PARTIE 6 – Vérification du service cron
systemctl status cron
image13
Vérification des journaux
journalctl -u cron
image14
ou

cat /var/log/syslog | grep CRON

image15

## PARTIE 7 – Dépannage
Problème	Cause	Solution
Permission denied	Script non exécutable	chmod +x
Échec useradd	Droits insuffisants	utiliser sudo
Archive vide	Mauvais chemin	vérifier /entreprise/data
Cron ne fonctionne pas	PATH incorrect	chemins absolus
PARTIE 8 – Améliorations
Suppression utilisateur
sudo userdel -r employe_temp
Gestion d’erreurs
if [ $? -ne 0 ]; then
   echo "Erreur lors de la sauvegarde" >> $LOG
fi

Conclusion
Ce TP permet de maîtriser l’automatisation sous Linux via Bash.

Les compétences acquises :

scripting
administration système
planification
diagnostic
