📄 Rapport – Script Bash d’automatisation

Numéro : 300150385

👨‍💻 Auteur

Belkacem Medjkoune
INF1102 – Administration système
Collège Boréal

🎯 Objectif

Le but de ce projet est de créer un script Bash permettant d’automatiser certaines tâches d’administration système sous Linux.
Le script permet d’exécuter plusieurs opérations automatiquement afin de gagner du temps et éviter les erreurs.

⚙️ Fonctionnalités du script

Le script script_gestion.sh permet de :

Créer des dossiers (/enterprise/data, /enterprise/backup, /enterprise/logs)
Créer des fichiers de test
Effectuer une sauvegarde des fichiers
Tester la connexion réseau (ping 8.8.8.8)
Créer une archive avec tar
Générer un fichier de log
🧱 Étapes de réalisation
1. Création des dossiers
sudo mkdir -p /enterprise/data
sudo mkdir -p /enterprise/backup
sudo mkdir -p /enterprise/logs

![wait](https://github.com/user-attachments/assets/9d932398-116d-4a38-86e2-05ed5ec63d08)


2. Création des fichiers de test
echo "fichier1" | sudo tee /enterprise/data/fichier1.txt
echo "fichier2" | sudo tee /enterprise/data/fichier2.txt

![wait](https://github.com/user-attachments/assets/fe3f2fef-99ee-4d5a-be9a-b1cbc4fa8218)


3. Exécution du script
sudo chmod +x /enterprise/script_gestion.sh
sudo /enterprise/script_gestion.sh

Le script effectue :

un test réseau (ping 8.8.8.8)
la création d’une archive avec tar
l’écriture dans un fichier log

![wait](https://github.com/user-attachments/assets/3857aed4-cab6-481c-b8e9-0cd50d27dd5a)


4. Vérification du backup
ls /enterprise/backup


![wait](https://github.com/user-attachments/assets/2bed892e-dfed-47bc-ac6a-50126f8b3040)

📂 Structure du projet (GitHub)
.
├── script_gestion.sh
├── README.md
└── images/

💡 Les dossiers /enterprise/data, /enterprise/backup et /enterprise/logs sont créés automatiquement par le script sur la machine Linux et ne font pas partie du dépôt GitHub.

✅ Conclusion

Ce projet m’a permis de comprendre comment automatiser des tâches avec Bash.
Le script fonctionne correctement et permet de gérer les fichiers, effectuer des sauvegardes et générer des logs automatiquement.
