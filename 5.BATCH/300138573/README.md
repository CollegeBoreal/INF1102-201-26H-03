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

```bash
ssh -i ~/.ssh/ma_cle.pk \
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/tmp/ssh_known_hosts_empty \
ubuntu@10.7.237.197
```

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
```

**Explication** : Ce script permet :

de tester la connectivité réseau
de sauvegarder les fichiers
de créer un utilisateur temporaire
de compresser les données
de journaliser toutes les opérations

**PARTIE 3** – Rendre le script exécutable

##Commande## :

```bash
sudo chmod +x /entreprise/script_gestion.sh
```

## Pour verifier il faut taper:

```bash
ls -l /entreprise
```

<img width="1482" height="239" alt="batch113" src="https://github.com/user-attachments/assets/6d4f8383-0eb4-4751-bca0-4118d06cfd62" />

**Résultat attendu** : Le script possède les permissions d’exécution.

**PARTIE 4** – Test manuel

Exécution du script

```bash
sudo /entreprise/script_gestion.sh
```

## Exécution dans le terminal

**Vérifications**

1. Vérification de la sauvegarde
   
```bash
ls /entreprise/backup
```
<img width="1482" height="209" alt="batch114" src="https://github.com/user-attachments/assets/9bceb7d9-692f-4880-9999-f85248b843a8" />


2. Vérification de l’utilisateur


```bash
cat /etc/passwd | grep employe_temp
```

**Résultat attendu** : L’utilisateur apparaît dans le système.

4. Vérification du log
   
```bash
cat /entreprise/logs/log.txt
```

<img width="1482" height="762" alt="batch115" src="https://github.com/user-attachments/assets/c0fcdc12-98d7-4ebb-bbb1-d91c5d6d8476" />


## PARTIE 5 – Planification avec cron

**Étape 5** : Configuration

```bash
sudo crontab -e
```

<img width="1482" height="102" alt="batch116" src="https://github.com/user-attachments/assets/8a961fae-7cef-48c7-a6cd-0278d6213975" />

## Ajouter :

```bash
0 2 * * * /entreprise/script_gestion.sh
```

<img width="1482" height="762" alt="batch1" src="https://github.com/user-attachments/assets/2c9272e7-1c72-44cf-837b-ff3c7967e4c9" />

ligne ajoutée dans la crontab
Explication : Exécution automatique tous les jours à 02h00.

## PARTIE 6 – Vérification du service cron

```bash
systemctl status cron
```

<img width="1482" height="536" alt="batch117" src="https://github.com/user-attachments/assets/5071c548-31b9-41ab-bc1f-9175e98f698b" />


## Vérification des journaux

```bash
journalctl -u cron
```

<img width="1482" height="762" alt="batch118" src="https://github.com/user-attachments/assets/31d1b633-e954-4211-ba65-cd6cc16862b4" />

ou

```bash
cat /var/log/syslog | grep CRON
```

<img width="1482" height="762" alt="batch119" src="https://github.com/user-attachments/assets/522e738d-c8f5-411d-8ba1-1c73408793f4" />


## Conclusion

Ce TP permet de maîtriser l’automatisation sous Linux via Bash.

Les compétences acquises :

scripting
administration système
planification
diagnostic
