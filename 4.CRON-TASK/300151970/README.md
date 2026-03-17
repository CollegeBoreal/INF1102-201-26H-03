# Linux — Gestionnaire de tâches & Observateur d’évènements

## Analyse des logs Nginx et automatisation avec Cron

## 👤 Informations de l’étudiant

Nom : **Babatundé Adissa Fadolle AROUNA**

Numéro étudiant : **300151970**

Cours : **INF1102 – Programmation des Systèmes**

**Collège Boréal - Campus Toronto**

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

<img width="695" height="98" alt="image 0" src="https://github.com/user-attachments/assets/4367a80f-2ddf-4eae-a42c-f7c03bf1c4ec" />


### Résultat obtenu

Connexion réussie au serveur :

```
Welcome to Ubuntu 22.04.5 LTS
IPv4 address for eth0: 10.7.237.223
Memory usage: 17%
```

<img width="974" height="699" alt="1 1" src="https://github.com/user-attachments/assets/ef6ab88d-368e-4410-8072-274302bf7b06" />


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

<img width="792" height="85" alt="image 1" src="https://github.com/user-attachments/assets/98199403-e37f-4cc0-af7a-9a72cf389991" />


➡️ Ajouter la capture du terminal.

### Résultat obtenu

```
10.250.0.38
10.250.0.38
10.250.0.38
```

<img width="807" height="137" alt="image 2" src="https://github.com/user-attachments/assets/77d15ce1-63c8-48ea-8acb-c86dc9a90a32" />

### Explication

La commande **awk** permet d’extraire la première colonne du fichier log.
Dans ce fichier, la première colonne correspond à l’adresse IP du visiteur.

---

# 4️⃣ Suppression des doublons

Pour afficher seulement les IP uniques :

```bash
awk '{print $1}' /var/log/nginx/access.log | sort | uniq
```

<img width="957" height="26" alt="image 3" src="https://github.com/user-attachments/assets/fa953100-b267-45eb-bcc2-41c7951d779a" />


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

<img width="1316" height="25" alt="image 4" src="https://github.com/user-attachments/assets/83a93913-f4d2-4520-845c-4d1b29a9e3bb" />

➡️ Ajouter la capture.

### Résultat obtenu

Vérification avec :

```bash
cat /home/ubuntu/nginx_ips.txt
```

<img width="812" height="110" alt="image 5" src="https://github.com/user-attachments/assets/ddfa70d4-586d-482c-b310-6bbb1e39b453" />

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

<img width="721" height="22" alt="image 6" src="https://github.com/user-attachments/assets/f1db5468-5551-4172-b308-0eb2c737a593" />

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

<img width="770" height="23" alt="image 7" src="https://github.com/user-attachments/assets/8758fd44-fb1a-4eda-aaac-a9a09c31b42c" />

### Test du script

```bash
/home/ubuntu/scruter_nginx.sh
```

<img width="756" height="67" alt="image 8" src="https://github.com/user-attachments/assets/96076dab-860f-4f8f-a94c-9c5f07592db8" />

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

<img width="762" height="256" alt="image 9" src="https://github.com/user-attachments/assets/370228e0-6ba2-412f-a24a-cdd8605c4117" />

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

<img width="1005" height="257" alt="image 10" src="https://github.com/user-attachments/assets/1aa88547-1900-45d6-aea7-d40a20c730e8" />

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

<img width="1122" height="253" alt="image 11" src="https://github.com/user-attachments/assets/22119002-67e9-424b-9788-330de50b3a6b" />

Ce dossier servira à stocker les captures d’écran du laboratoire.

---

# 9️⃣ Gestion du projet avec Git

Ajout des fichiers :

```bash
git add .
```

<img width="1592" height="52" alt="image 12" src="https://github.com/user-attachments/assets/b246c894-1ddf-45a1-9970-125ffac7932a" />

Commit :

```bash
git commit -m "Je suis étudiant au collège boréal"
```

<img width="1417" height="141" alt="image 13" src="https://github.com/user-attachments/assets/6c3065f2-44b6-4e16-b8d2-3cb7c874be95" />

Synchronisation avec le dépôt distant :

```bash
git pull
git push
```

<img width="1196" height="536" alt="image 14" src="https://github.com/user-attachments/assets/b7c7281a-2077-4a12-9bf4-b9321a5981f3" />

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


