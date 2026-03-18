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
<img width="963" height="588" alt="image0" src="https://github.com/user-attachments/assets/dc0bcf6d-7cb2-4a9a-a513-839d8eab22cb" />

## PARTIE 1 – Préparation de l’environnement

### Étape 1 : Création de la structure

Commande :

```bash
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs
```

<img width="652" height="73" alt="image1" src="https://github.com/user-attachments/assets/540cc870-74c9-4a05-aa22-81b2b72384eb" />



* Pour verifier, il faut taper :

```bash
ls -R /entreprise
```

<img width="798" height="231" alt="image2" src="https://github.com/user-attachments/assets/385593f4-fa6e-42c8-9e28-f5d01fa7c084" />


Résultat attendu :

```
/entreprise:
backup data logs script_gestion.sh

/entreprise/backup:

/entreprise/data:
fichier1.txt  fichier2.txt

/entreprise/logs:
```


Explication :
L’option `-p` permet de créer les dossiers parents si nécessaire.

### Création de fichiers de test

Commande :

```bash
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```

<img width="962" height="118" alt="image3" src="https://github.com/user-attachments/assets/6dbd42d7-bc4e-49a5-97b6-1ef496129bed" />

Pour verifier

```bash
ls /entreprise/data
```

<img width="627" height="71" alt="image4" src="https://github.com/user-attachments/assets/e9e33095-74fd-4280-90ac-22f1ae6a58e1" />

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

<img width="793" height="27" alt="image5" src="https://github.com/user-attachments/assets/7dda8966-8f83-4f2e-b707-bd3b8e186876" />

* Contenu complet du script dans l’éditeur nano

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

*Explication* :
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

<img width="852" height="27" alt="image6" src="https://github.com/user-attachments/assets/38923d90-b3ce-4e94-8060-c782a25eb4be" />

Pour verifier il faut taper:

```bash
ls -l /entreprise
```

<img width="773" height="172" alt="image7" src="https://github.com/user-attachments/assets/7ed05799-4122-4e42-ab5f-d3424455e6ec" />

Résultat attendu :
Le script possède les permissions d’exécution.

---

## PARTIE 4 – Test manuel

### Exécution du script

```bash
sudo /entreprise/script_gestion.sh
```

<img width="728" height="50" alt="image8" src="https://github.com/user-attachments/assets/af2419dc-5e67-4de7-9a0d-7f77f872fd87" />


* Exécution dans le terminal

---

### Vérifications

#### 1. Vérification de la sauvegarde

```bash
ls /entreprise/backup
```

<img width="732" height="82" alt="image9" src="https://github.com/user-attachments/assets/02362c46-3cb7-41e7-a8c4-375000fcb7d8" />

Résultat attendu :

backup_2026-03-18.tar.gz               fichier1.txt      fichier2.txt

---

#### 2. Vérification de l’utilisateur

```bash
cat /etc/passwd | grep employe_temp
```
<img width="723" height="27" alt="image10" src="https://github.com/user-attachments/assets/eb64016a-03c5-4c35-8f17-d8e0af87046c" />

Résultat attendu :
L’utilisateur apparaît dans le système.

---
#### 3. Vérification du log

```bash
cat /entreprise/logs/log.txt
```
<img width="790" height="972" alt="image11" src="https://github.com/user-attachments/assets/1c715955-30d4-4d8a-82c8-02a4b9bf9224" />

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

<img width="943" height="832" alt="image12 0" src="https://github.com/user-attachments/assets/feb58670-d3cc-44a4-b660-05969d0f059a" />

Ajouter :

```bash
0 2 * * * /entreprise/script_gestion.sh
```

<img width="919" height="952" alt="image12" src="https://github.com/user-attachments/assets/c876320c-744e-4454-ada9-4bed66a191f3" />


* ligne ajoutée dans la crontab

Explication :
Exécution automatique tous les jours à 02h00.

---

## PARTIE 6 – Vérification du service cron

```bash
systemctl status cron
```
<img width="948" height="538" alt="image13" src="https://github.com/user-attachments/assets/acd2a811-7959-4846-b6da-cf6dcedd9b6e" />

---

### Vérification des journaux

```bash
journalctl -u cron
```

<img width="939" height="967" alt="image14" src="https://github.com/user-attachments/assets/7b63a8e3-90b3-4e28-987a-b961b47db5f1" />




ou


```bash
cat /var/log/syslog | grep CRON
```

<img width="949" height="941" alt="image15" src="https://github.com/user-attachments/assets/4fb5c739-3e14-40f6-bc1e-677ee4198b1a" />


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
