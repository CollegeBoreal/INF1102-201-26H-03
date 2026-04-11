1. Préparation de l’environnement

Pour commencer, les dossiers de travail et les fichiers de test ont été créés.

Commandes utilisées
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs

echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
Vérification du contenu
cat /entreprise/data/fichier1.txt
cat /entreprise/data/fichier2.txt
Capture
<p align="center"> <img src="images/Image15.png" alt="Vérification du contenu des fichiers de test" width="900"> </p>
2. Création du script Batch

Le script principal a été créé dans le fichier /entreprise/script_gestion.sh.

Commande utilisée
sudo nano /entreprise/script_gestion.sh
Capture de la création du script
<p align="center"> <img src="images/Image16.png" alt="Création du fichier script_gestion.sh" width="900"> </p>
Code du script
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
Explication

Ce script permet de :

tester le réseau avec ping
copier les fichiers du dossier data vers backup
créer l’utilisateur temporaire employe_temp
compresser les données dans une archive .tar.gz
enregistrer toutes les étapes dans log.txt
Capture du script
<p align="center"> <img src="images/Image17.png" alt="Contenu du script script_gestion.sh" width="900"> </p>
3. Rendre le script exécutable

Après sa création, le script doit recevoir les permissions nécessaires.

Commande utilisée
sudo chmod +x /entreprise/script_gestion.sh
4. Test manuel du script

Le script a ensuite été exécuté manuellement afin de vérifier qu’il fonctionne correctement.

Commande utilisée
sudo /entreprise/script_gestion.sh
Vérifications possibles
ls -lh /entreprise/backup
cat /entreprise/logs/log.txt
cat /etc/passwd | grep employe_temp
Explication

Cette étape permet de confirmer que :

les fichiers sont sauvegardés
une archive est créée
l’utilisateur temporaire est ajouté
le journal d’exécution est bien généré
Capture du fichier log
<p align="center"> <img src="images/Image18.png" alt="Contenu du fichier log.txt" width="900"> </p>
5. Planification avec Cron

Le script a ensuite été planifié pour s’exécuter automatiquement chaque jour à 02h00.

Commandes utilisées
sudo crontab -e
sudo crontab -l
Ligne ajoutée
0 2 * * * /entreprise/script_gestion.sh
Explication

Cette ligne indique au système de lancer automatiquement le script tous les jours à 2 heures du matin.

Capture de la crontab
<p align="center"> <img src="images/Image19.png" alt="Vérification de la crontab" width="900"> </p>
6. Vérification du service cron

Après la planification, il faut vérifier que le service cron fonctionne correctement.

Commande utilisée
sudo systemctl status cron
Explication

Cette commande permet de confirmer que le service cron est actif et prêt à exécuter les tâches planifiées.

Capture
<p align="center"> <img src="images/Image20.png" alt="État du service cron" width="900"> </p>
7. Vérification des journaux cron

Pour suivre l’exécution automatique et diagnostiquer d’éventuels problèmes, les journaux du service cron ont été consultés.

Commande utilisée
journalctl -u cron
Explication

Cette commande permet d’afficher l’historique du service cron et de vérifier les exécutions automatiques.

Capture
<p align="center"> <img src="images/Image21.png" alt="Journaux du service cron" width="900"> </p>
8. Dépannage et amélioration

Pour tester la robustesse du script, l’utilisateur temporaire a été supprimé puis le script a été relancé.

Commandes utilisées
sudo userdel -r employe_temp
id employe_temp
sudo /bin/bash /entreprise/script_gestion.sh
Explication

Cette étape montre que :

l’utilisateur temporaire peut être supprimé manuellement
la commande id employe_temp confirme son absence
le script peut recréer automatiquement l’utilisateur lors d’une nouvelle exécution
Capture
<p align="center"> <img src="images/Image22.png" alt="Suppression de l'utilisateur temporaire et relance du script" width="900"> </p>
✅ Résultat final

À la fin du TP, le système permet de :

sauvegarder automatiquement les fichiers
créer un utilisateur temporaire
tester la connectivité réseau
générer un fichier journal
planifier l’exécution avec cron
vérifier les journaux système
📊 Avant et après exécution
Avant exécution
/entreprise/
├── data/
│   ├── fichier1.txt
│   └── fichier2.txt
├── backup/
│   └── (vide ou ancien contenu)
└── logs/
    └── log.txt
Après exécution
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
Flux de données
data/  ─────copie─────▶  backup/
data/  ─────archive───▶  backup/backup_YYYY-MM-DD.tar.gz
script ───────────────▶  logs/log.txt
🏁 Conclusion

Ce TP m’a permis de mettre en pratique l’automatisation de tâches d’administration système sous Linux avec un script Batch.

J’ai pu créer un environnement de travail, développer un script complet, tester son exécution, planifier son lancement avec cron et vérifier son bon fonctionnement grâce aux journaux système et aux différentes captures d’écran.
