👤 Étudiant

Identifiant : 300141368

Nom: Diwambuena Kembo Daniella

Cours : Programmation système

Thème : BATCH

1. Cette partie consiste à créer la structure de dossiers et les fichiers de test nécessaires afin de préparer l’environnement dans lequel le script pourra fonctionner correctement.

```powershell
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs
```


```powershell
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```

<img width="921" height="257" alt="image" src="https://github.com/user-attachments/assets/23f04274-99e5-4c2d-8fbe-37a3faf5042b" />


2. Cette partie consiste à créer et écrire le script Batch script_gestion.sh, qui automatise la sauvegarde des fichiers, le test réseau, la création d’un utilisateur temporaire, la compression des données et la génération d’un fichier log.
   ```powershell
   sudo nano /entreprise/script_gestion.sh
   ```


3.

Cette capture montre l’édition de la crontab dans l’éditeur Nano, où l’on configure les tâches automatisées que le système exécutera selon une planification définie.

4.
   Cette capture montre le fichier de log généré par le script, qui enregistre chaque étape de l’exécution, y compris le test réseau, la sauvegarde des fichiers, la création de l’utilisateur et l’archivage.


5.

   Cette capture montre l’historique complet des archives générées automatiquement par cron, avec un fichier de sauvegarde créé chaque jour à 02h00, ce qui confirme que la planification fonctionne correctemen

