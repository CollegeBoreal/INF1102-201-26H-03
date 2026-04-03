** 🌍 Projet de Surveillance de la Qualité de l'Air (AQI) - Montréal**

**Étudiant :** Hanane Zerrouki  

**Matricule :** 300147816  

**Cours :** INF1102 - Programmation des systèmes


## 📝 Description du Projet

Ce projet démontre l'automatisation d'un pipeline de données sous Linux. Nous récupérons les données AQI de Montréal via l'API OpenWeatherMap, les stockons localement sur une VM Ubuntu, et les analysons via un notebook Jupyter.

## 📁 Structure des Dossiers

Conformément aux exigences du script de test :

* `scripts/` : Contient le script Bash `collecter_air.sh`.

* `data/` : Fichiers JSON bruts (Preuve de collecte).

* `output/` : Données traitées.
![Creer les dossiers](./images/1.JPG)

* `RAPPORT.ipynb` : Analyse visuelle et graphique.

## 🛠️ Étapes Réalisées 

Avant de commencer, j'ai utilisé ce site pour avoir un nouveau token:

![Token](./images/token.JPG)


Aprés avoir saisi mon adresse email et mon nom j'ai réussi à avoir le nouveau token:

![Token](./images/token2.JPG)

### 1. Script de Collecte et Permissions

Le script utilise `curl` pour l'API. Les permissions d'exécution ont été accordées avec `chmod +x`.

Je teste le script analyse.sh comme suit:

![Test](./images/testsucces.JPG)

 Un nouveau fichier air quality est crée:

![Air quality](./images/air.JPG)

### 2. Automatisation avec Cron

L'automatisation est gérée par la Crontab de l'utilisateur Ubuntu.

**Configuration :**

`0 * * * * bash /home/ubuntu/INF1102-201-26H-03/8.Project/300147816/scripts/collecter_air.sh`
*(Voir capture d'écran de crontab -l ou du syslog montrant l'exécution)*

### 3. Analyse Jupyter (RAPPORT.ipynb)
Le rapport contient :
* Une description de la méthode.
* Le code Python commenté.
* Un graphique Matplotlib montrant l'évolution de l'AQI.

## ✅ Conclusion
Le projet est entièrement fonctionnel, automatisé et respecte la structure de fichiers demandée pour la correction automatique.
