👤 Étudiant
Identifiant : 300141429
Nom: Elhadji Arona Barry
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
![](images/image1.png)

2. Cette partie consiste à créer et écrire le script Batch script_gestion.sh, qui automatise la sauvegarde des fichiers, le test réseau, la création d’un utilisateur temporaire, la compression des données et la génération d’un fichier log.
   ```powershell
   sudo nano /entreprise/script_gestion.sh
   ```
![](images/image2.png)   

3. <img width="1535" height="776" alt="image" src="https://github.com/user-attachments/assets/ab6dd24e-7108-45ea-8bb2-3568e07e48dc" />

Cette capture montre l’édition de la crontab dans l’éditeur Nano, où l’on configure les tâches automatisées que le système exécutera selon une planification définie.

4.  <img width="972" height="692" alt="image3" src="https://github.com/user-attachments/assets/d3749eb6-c62f-4fd0-9972-b4726939c79b" />
   Cette capture montre le fichier de log généré par le script, qui enregistre chaque étape de l’exécution, y compris le test réseau, la sauvegarde des fichiers, la création de l’utilisateur et l’archivage.


5. <img width="1161" height="257" alt="image4" src="https://github.com/user-attachments/assets/b8c1719a-5cfb-4b5d-ab7d-dbf8ea7d8ddd" />

   Cette capture montre l’historique complet des archives générées automatiquement par cron, avec un fichier de sauvegarde créé chaque jour à 02h00, ce qui confirme que la planification fonctionne correctemen
