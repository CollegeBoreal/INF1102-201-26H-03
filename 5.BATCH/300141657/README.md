# TP – Automatisation d’administration avec script Batch (Linux)

## Informations de l’étudiant
- **Identifiant :** 300141429
- **Nom :** Elhadji Arona
- **Cours :** Programmation système
- **Thème :** BATCH

---

## Objectif

Ce TP consiste à automatiser des tâches d’administration système sous Linux à l’aide d’un script Batch.

Le script permet de :

- sauvegarder un dossier d’entreprise
- créer un utilisateur temporaire
- tester la connectivité réseau
- générer un fichier journal
- planifier l’exécution automatique avec cron
- vérifier l’exécution et diagnostiquer les erreurs

---

## Environnement requis

- Ubuntu Server
- Accès `sudo`
- Terminal Linux
- Service `cron` actif

---

## Structure du projet

```bash
/entreprise
├── data
│   ├── fichier1.txt
│   └── fichier2.txt
├── backup
│   ├── fichier1.txt
│   ├── fichier2.txt
│   └── backup_YYYY-MM-DD.tar.gz
├── logs
│   └── log.txt
└── script_gestion.sh
```

---

## 1. Préparation de l’environnement

Les dossiers de travail et les fichiers de test ont été créés au début du TP.

### Commandes utilisées

```bash
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs

echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```

### Vérification du contenu

```bash
cat /entreprise/data/fichier1.txt
cat /entreprise/data/fichier2.txt
```

### Capture

<p align="center">
  <img src="images/Image15.png" alt="Vérification du contenu des fichiers de test" width="900">
</p>

---

## 2. Création du script Batch

Le script principal a été créé dans le fichier `/entreprise/script_gestion.sh`.

### Commande utilisée

```bash
sudo nano /entreprise/script_gestion.sh
```

### Capture de la création du fichier

<p align="center">
  <img src="images/Image16.png" alt="Création du fichier script_gestion.sh" width="900">
</p>

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

### Rôle du script

Ce script permet de :

- tester la connectivité réseau avec `ping`
- copier les fichiers du dossier `data` vers `backup`
- créer l’utilisateur temporaire `employe_temp`
- générer une archive compressée
- enregistrer toutes les opérations dans `log.txt`

### Capture du contenu du script

<p align="center">
  <img src="images/Image17.png" alt="Contenu du script script_gestion.sh" width="900">
</p>

---

## 3. Rendre le script exécutable

Après sa création, le script doit être rendu exécutable.

### Commande utilisée

```bash
sudo chmod +x /entreprise/script_gestion.sh
```

---

## 4. Test manuel du script

Le script a ensuite été exécuté manuellement afin de vérifier son bon fonctionnement.

### Commande utilisée

```bash
sudo /entreprise/script_gestion.sh
```

### Vérifications

```bash
ls -lh /entreprise/backup
cat /entreprise/logs/log.txt
cat /etc/passwd | grep employe_temp
```

### Explication

Cette étape permet de confirmer que :

- les fichiers sont bien copiés dans `backup`
- une archive `.tar.gz` est créée
- l’utilisateur temporaire est bien ajouté
- le journal d’exécution est correctement généré

### Capture du fichier log

<p align="center">
  <img src="images/Image18.png" alt="Contenu du fichier log.txt" width="900">
</p>

---

## 5. Planification avec cron

Le script a ensuite été planifié pour s’exécuter automatiquement tous les jours à **02h00**.

### Commandes utilisées

```bash
sudo crontab -e
sudo crontab -l
```

### Ligne ajoutée dans la crontab

```bash
0 2 * * * /entreprise/script_gestion.sh
```

### Explication

Cette ligne signifie que le script sera exécuté automatiquement chaque jour à 2 heures du matin.

### Capture de la crontab

<p align="center">
  <img src="images/Image19.png" alt="Vérification de la crontab" width="900">
</p>

---

## 6. Vérification du service cron

Une fois la planification effectuée, il faut vérifier que le service `cron` fonctionne correctement.

### Commande utilisée

```bash
sudo systemctl status cron
```

### Explication

Cette commande confirme que le service `cron` est actif et prêt à exécuter les tâches planifiées.

### Capture

<p align="center">
  <img src="images/Image20.png" alt="État du service cron" width="900">
</p>

---

## 7. Vérification des journaux cron

Les journaux du service `cron` ont été consultés pour confirmer l’exécution automatique et diagnostiquer d’éventuels problèmes.

### Commande utilisée

```bash
journalctl -u cron
```

### Explication

Cette commande permet d’afficher l’historique du service `cron` et de suivre les tâches exécutées automatiquement.

### Capture

<p align="center">
  <img src="images/Image21.png" alt="Journaux du service cron" width="900">
</p>

---

## 8. Dépannage et amélioration

Pour tester la robustesse du script, l’utilisateur temporaire a été supprimé, puis le script a été relancé.

### Commandes utilisées

```bash
sudo userdel -r employe_temp
id employe_temp
sudo /bin/bash /entreprise/script_gestion.sh
```

### Explication

Cette étape montre que :

- l’utilisateur temporaire peut être supprimé manuellement
- la commande `id employe_temp` confirme ensuite son absence
- le script peut recréer automatiquement l’utilisateur lors d’une nouvelle exécution

### Capture

<p align="center">
  <img src="images/Image22.png" alt="Suppression de l'utilisateur temporaire puis relance du script" width="900">
</p>

---

## Résultat final

À la fin du TP, le système permet de :

- sauvegarder automatiquement les fichiers
- créer un utilisateur temporaire
- tester la connectivité réseau
- générer un fichier journal
- planifier l’exécution avec cron
- vérifier les journaux système

---

## Avant et après exécution

### Avant exécution

```bash
/entreprise/
├── data/
│   ├── fichier1.txt
│   └── fichier2.txt
├── backup/
│   └── (vide ou ancien contenu)
└── logs/
    └── log.txt
```

### Après exécution

```bash
/entreprise/
├── data/
│   ├── fichier1.txt
│   └── fichier2.txt
├── backup/
│   ├── fichier1.txt
│   ├── fichier2.txt
│   └── backup_YYYY-MM-DD.tar.gz
└── logs/
    └── log.txt
```

### Flux de données

```bash
data/  ─────copie─────▶  backup/
data/  ─────archive───▶  backup/backup_YYYY-MM-DD.tar.gz
script ───────────────▶  logs/log.txt
```

---

## Conclusion

Ce TP m’a permis de mettre en pratique l’automatisation de tâches d’administration système sous Linux avec un script Batch.

J’ai pu créer l’environnement de travail, rédiger un script complet, tester son exécution, planifier son lancement avec `cron` et vérifier son bon fonctionnement grâce aux journaux système et aux captures d’écran.
