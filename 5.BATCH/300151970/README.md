# TP Automatisation d’administration avec script Bash (Linux)

---

## Informations de l’étudiant

* Nom et Prénoms: Babatundé Adissa Fadolle Arouna
* Programme : Techniques des systèmes informatiques
* Cours : INF 1102-201 – Programmation de systèmes
* Session : Hiver 2026
* Professeur : Brice Robert
* Date de remise : 17/03/2026

---

## Objectif

Ce travail pratique vise à automatiser des tâches d’administration sous Linux à l’aide d’un script Bash.

Les objectifs sont les suivants :

* Sauvegarder un dossier d’entreprise
* Créer un utilisateur temporaire
* Tester la connectivité réseau
* Générer un fichier journal (log)
* Planifier l’exécution avec cron
* Vérifier l’exécution et diagnostiquer les erreurs

---

## Environnement requis

* Distribution Linux (Ubuntu Server recommandé)
* Accès administrateur (sudo)
* Terminal
* Service cron actif

---


## Connexion au serveur Linux
Pour accéder au serveur Ubuntu, j’ai utilisé une connexion SSH avec une clé privée.

Commande utilisée

  ```bash
ssh -i ~/.ssh/ma_cle.pk \
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/tmp/ssh_known_hosts_empty \
ubuntu@10.7.237.223
```
<img width="952" height="875" alt="image0" src="https://github.com/user-attachments/assets/dbc5dc99-e6cb-4d0a-8b04-847a5979823f" />


## PARTIE 1 – Préparation de l’environnement

### Étape 1 : Création de la structure

Commande :

```bash
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs
```

Capture à insérer :

* Résultat de la commande suivante :

```bash
ls -R /entreprise
```

Résultat attendu :

```
/entreprise/
├── data
├── backup
└── logs
```

Explication :
L’option `-p` permet de créer les dossiers parents si nécessaire.

---

### Étape 2 : Création de fichiers de test

Commande :

```bash
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```

Capture à insérer :

```bash
ls /entreprise/data
```

Résultat attendu :

```
fichier1.txt
fichier2.txt
```

Explication :
La commande `tee` permet d’écrire dans un fichier avec les droits administrateur.

---

## PARTIE 2 – Création du script Bash

### Étape 3 : Création du script

Commande :

```bash
sudo nano /entreprise/script_gestion.sh
```

Capture à insérer :

* Contenu complet du script dans l’éditeur nano

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
```

Explication :
Ce script permet :

* de tester la connectivité réseau
* de sauvegarder les fichiers
* de créer un utilisateur temporaire
* de compresser les données
* de journaliser toutes les opérations

---

## PARTIE 3 – Rendre le script exécutable

Commande :

```bash
sudo chmod +x /entreprise/script_gestion.sh
```

Capture à insérer :

```bash
ls -l /entreprise
```

Résultat attendu :
Le script possède les permissions d’exécution.

---

## PARTIE 4 – Test manuel

### Étape 4 : Exécution du script

```bash
sudo /entreprise/script_gestion.sh
```

Capture à insérer :

* Exécution dans le terminal

---

### Vérifications

#### 1. Vérification de la sauvegarde

```bash
ls /entreprise/backup
```

Capture à insérer

Résultat attendu :

* fichiers copiés
* archive .tar.gz

---

#### 2. Vérification de l’utilisateur

```bash
cat /etc/passwd | grep employe_temp
```

Capture à insérer

Résultat attendu :
L’utilisateur apparaît dans le système.

---

#### 3. Vérification du log

```bash
cat /entreprise/logs/log.txt
```

Capture à insérer

Résultat attendu :

```
Début exécution : ...
Test réseau...
Sauvegarde en cours...
Utilisateur créé.
Fin exécution : ...
```

Explication :
Le fichier log enregistre toutes les actions exécutées.

---

## PARTIE 5 – Planification avec cron

### Étape 5 : Configuration

```bash
sudo crontab -e
```

Ajouter :

```bash
0 2 * * * /entreprise/script_gestion.sh
```

Capture à insérer :

* ligne ajoutée dans la crontab

Explication :
Exécution automatique tous les jours à 02h00.

---

## PARTIE 6 – Vérification du service cron

```bash
systemctl status cron
```

Capture à insérer

---

### Vérification des journaux

```bash
journalctl -u cron
```

ou

```bash
cat /var/log/syslog | grep CRON
```

Captures à insérer

---

## PARTIE 7 – Dépannage

| Problème               | Cause                 | Solution                  |
| ---------------------- | --------------------- | ------------------------- |
| Permission denied      | Script non exécutable | chmod +x                  |
| Échec useradd          | Droits insuffisants   | utiliser sudo             |
| Archive vide           | Mauvais chemin        | vérifier /entreprise/data |
| Cron ne fonctionne pas | PATH incorrect        | chemins absolus           |

---

## PARTIE 8 – Améliorations

### Suppression utilisateur

```bash
sudo userdel -r employe_temp
```

---

### Gestion d’erreurs

```bash
if [ $? -ne 0 ]; then
   echo "Erreur lors de la sauvegarde" >> $LOG
fi
```

---

## Résultat attendu

### Avant exécution

```
/entreprise/
├── data/
├── backup/
└── logs/
```

---

### Après exécution

```
/entreprise/
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
```

---

## Conclusion

Ce TP permet de maîtriser l’automatisation sous Linux via Bash.

Les compétences acquises :

* scripting
* administration système
* planification
* diagnostic

---


---
