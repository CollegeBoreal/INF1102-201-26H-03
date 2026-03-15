# Lab 5 – Script Batch Linux

**Cours :** INF1102 – Administration Linux  
**Étudiant :** 300150485  
**Collège :** Collège Boréal  

---

# Objectif

Le but de ce laboratoire est de créer un **script Bash automatisé** permettant de simuler des tâches d’administration dans une entreprise.

Le script doit :

- sauvegarder un dossier de données
- tester la connectivité réseau
- créer un utilisateur temporaire
- générer un fichier journal (log)
- compresser les fichiers sauvegardés
- automatiser l’exécution avec **cron**

---

# Structure du projet
/entreprise
│
├── data
│ ├── fichier1.txt
│ └── fichier2.txt
│
├── backup
│ ├── fichier1.txt
│ ├── fichier2.txt
│ └── backup_DATE.tar.gz
│
└── logs
└── log.txt


---

# Fonctionnement du script

Le script `script_gestion.sh` effectue les opérations suivantes :

1. Enregistre la date et l'heure dans un fichier **log**
2. Teste la connectivité réseau avec la commande `ping`
3. Sauvegarde les fichiers du dossier `/entreprise/data`
4. Crée un utilisateur temporaire nommé **employe_temp**
5. Compresse les données dans une archive `.tar.gz`
6. Enregistre toutes les actions dans le fichier **log**

---

# Commandes utilisées

Ce laboratoire utilise plusieurs commandes Linux importantes :

| Commande | Description |
|--------|-------------|
| `mkdir` | création de dossiers |
| `cp` | copie de fichiers |
| `tar` | compression de fichiers |
| `ping` | test réseau |
| `useradd` | création d'utilisateur |
| `chpasswd` | définition du mot de passe |
| `cron` | automatisation des tâches |
| `chmod` | gestion des permissions |

---

# Automatisation avec Cron

Le script est programmé pour s’exécuter automatiquement avec la tâche cron suivante :


0 2 * * * /entreprise/script_gestion.sh


Cela signifie que le script sera exécuté **tous les jours à 02h00**.

---

# Vérification

Les vérifications suivantes ont été effectuées :

- sauvegarde des fichiers dans `/entreprise/backup`
- création de l’utilisateur `employe_temp`
- génération du fichier `/entreprise/logs/log.txt`
- confirmation que le service **cron** est actif

---

# Conclusion

Ce laboratoire démontre l’utilisation de **scripts Bash pour automatiser des tâches système sous Linux**.  
Il permet de comprendre comment combiner différentes commandes Linux afin de gérer des sauvegardes, créer des utilisateurs et planifier des tâches automatiques dans un environnement serveur.
