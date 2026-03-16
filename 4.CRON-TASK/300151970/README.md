# Linux — Gestionnaire de tâches & Observateur d’évènements

## Analyse des logs Nginx et automatisation avec Cron

## 👤 Informations de l’étudiant

Nom : **Babatundé Adissa Fadolle AROUNA**

Numéro étudiant : **300151970**

Cours : **INF1102 – Programmation des Systèmes**

Collège : **Collège Boréal - Campus Toronto**

Laboratoire : **CRON-TASK — Analyse des logs Nginx**

---

# 🎯 Objectif du laboratoire

Dans ce laboratoire, j’ai appris à analyser les journaux d’un serveur web Nginx afin d’identifier les adresses IP des visiteurs.

Les objectifs étaient :

* se connecter à une machine Linux avec **SSH**
* analyser les logs du serveur **Nginx**
* extraire les adresses IP avec **awk**
* créer un **script shell** pour automatiser la tâche
* programmer l’exécution automatique avec **cron**
* versionner le travail avec **Git et GitHub**

---

# 1️⃣ Connexion au serveur Linux

Pour accéder au serveur Ubuntu, j’ai utilisé une connexion SSH avec une clé privée.

### Commande utilisée

```bash
ssh -i ~/.ssh/ma_cle.pk \
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/tmp/ssh_known_hosts_empty \
ubuntu@10.7.237.223
```

![Description de l'image](images/1.1.png)

➡️ Ajouter ici la capture de la connexion SSH.

### Résultat obtenu

Connexion réussie au serveur :

```
Welcome to Ubuntu 22.04.5 LTS
IPv4 address for eth0: 10.7.237.223
Memory usage: 17%
```

### Explication

Cette commande permet de se connecter à la machine virtuelle Ubuntu à l’aide d’une clé SSH.

---

# 2️⃣ Analyse des logs Nginx

Les logs du serveur web se trouvent dans le fichier :

```
/var/log/nginx/access.log
```

Ce fichier contient toutes les requêtes HTTP reçues par le serveur.

---

# 3️⃣ Extraction des adresses IP

Pour extraire les adresses IP des visiteurs, j’ai utilisé la commande suivante :

```bash
awk '{print $1}' /var/log/nginx/access.log
```

### 📸 Capture d’écran

➡️ Ajouter la capture du terminal.

### Résultat obtenu

```
10.250.0.38
10.250.0.38
10.250.0.38
```

### Explication

La commande **awk** permet d’extraire la première colonne du fichier log.
Dans ce fichier, la première colonne correspond à l’adresse IP du visiteur.

---

# 4️⃣ Suppression des doublons

Pour afficher seulement les IP uniques :

```bash
awk '{print $1}' /var/log/nginx/access.log | sort | uniq
```

### 📸 Capture d’écran

➡️ Ajouter la capture.

### Résultat obtenu

```
10.250.0.38
```

### Explication

* `sort` trie les résultats
* `uniq` supprime les doublons

Cela permet d’obtenir une liste unique des visiteurs.

---

# 5️⃣ Sauvegarde des IP dans un fichier

Pour enregistrer les adresses IP uniques dans un fichier :

```bash
awk '{print $1}' /var/log/nginx/access.log | sort | uniq > /home/ubuntu/nginx_ips.txt
```

### 📸 Capture d’écran

➡️ Ajouter la capture.

### Résultat obtenu

Vérification avec :

```bash
cat /home/ubuntu/nginx_ips.txt
```

Résultat :

```
10.250.0.38
```

---

# 6️⃣ Création d’un script d’automatisation

Pour automatiser cette tâche, j’ai créé un script shell.

### Création du fichier

```bash
nano /home/ubuntu/scruter_nginx.sh
```

### Contenu du script

```bash
#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"

awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE

echo "Script exécuté le $(date)" >> /home/ubuntu/nginx_ips.log
```

### Rendre le script exécutable

```bash
chmod +x /home/ubuntu/scruter_nginx.sh
```

### Test du script

```bash
/home/ubuntu/scruter_nginx.sh
```

### Résultat obtenu

Le fichier `nginx_ips.txt` contient :

```
10.250.0.38
```

---

# 7️⃣ Automatisation avec Cron

Pour exécuter le script automatiquement toutes les heures, j’ai configuré une tâche cron.

### Édition du crontab

```bash
crontab -e
```

Choix de l’éditeur :

```
1. /bin/nano
```

### Configuration ajoutée

```
0 * * * * /home/ubuntu/scruter_nginx.sh
```

### Vérification du service cron

```bash
systemctl status cron
```

### Résultat obtenu

```
cron.service - Regular background program processing daemon
Active: active (running)
```

Cela confirme que le service cron fonctionne correctement.

---

# 8️⃣ Organisation du projet avec Git

Sur ma machine locale, j’ai organisé mon travail dans le dépôt du cours.

### Création de mon dossier étudiant

```
4.CRON-TASK/300151970
```

### Structure du projet

```
300151970
│
├── README.md
├── scruter_nginx.sh
└── images
    └── .gitkeep
```

### Création du dossier images

```bash
mkdir images
```

Ce dossier servira à stocker les captures d’écran du laboratoire.

---

# 9️⃣ Gestion du projet avec Git

Ajout des fichiers :

```bash
git add .
```

Commit :

```bash
git commit -m "Je suis étudiant au collège boréal"
```

Synchronisation avec le dépôt distant :

```bash
git pull
git push
```

Le projet a été envoyé avec succès sur le dépôt GitHub du cours.

---

# ✅ Conclusion

Ce laboratoire m’a permis de mieux comprendre l’analyse des logs sous Linux et l’automatisation des tâches.

J’ai appris à :

* analyser les logs d’un serveur web
* extraire des informations avec `awk`
* automatiser un script avec `cron`
* organiser un projet avec `Git`
* synchroniser mon travail avec GitHub

Ces compétences sont importantes pour l’administration des systèmes Linux et la gestion des serveurs.


