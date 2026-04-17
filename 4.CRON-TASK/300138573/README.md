# Linux — Gestionnaire de tâches & Observateur d’évènements  
## Analyse des logs Nginx et automatisation avec Cron  

---

## 📌 Informations de l’étudiant  

Nom : Nour Miri 

Numéro étudiant : 300138573 

Cours : INF1102 – Programmation des Systèmes 

Collège Boréal - Campus Toronto 

Programme : Techniques des systèmes informatiques 

Session : Hiver 2026 

Professeur : Brice Robert 

Laboratoire : CRON-TASK — Analyse des logs Nginx 

---

## 🎯 Objectif du laboratoire  

Dans ce laboratoire, j’ai appris à analyser les logs d’un serveur web Nginx afin d’identifier les adresses IP des visiteurs et automatiser cette tâche.

Les objectifs étaient :  
- se connecter à une machine Linux avec SSH  
- analyser les logs Nginx  
- extraire les IP avec awk  
- créer un script bash  
- automatiser avec cron  
- utiliser Git et GitHub  

---

## 1️⃣ Connexion au serveur Linux  

Commande utilisée :

```bash
ssh -i ~/.ssh/ma_cle.pk -o StrictHostKeyChecking=no -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty ubuntu@10.7.237.197
````


<img width="1482" height="762" alt="image0" src="https://github.com/user-attachments/assets/187bfd91-3457-4a20-b8b3-c274d4ad94a2" />

<img width="1482" height="212" alt="Tronc-task1" src="https://github.com/user-attachments/assets/2ec64db5-558c-465c-9fa5-86c345b4cf30" />


Connexion réussie au serveur Ubuntu.

### Explication

Cette commande permet de se connecter à la machine virtuelle via SSH avec une clé privée.

---

## 2️⃣ Analyse des logs Nginx

Fichier utilisé :

/var/log/nginx/access.log

Ce fichier contient toutes les requêtes HTTP du serveur.

---

## 3️⃣ Extraction des adresses IP

Commande utilisée :

```bash
awk '{print $1}' /var/log/nginx/access.log
```

📸 image 1

### Résultat obtenu

127.0.0.1
127.0.0.1

📸 image 2

### Explication

La commande awk permet d’extraire la première colonne du fichier, qui correspond à l’adresse IP.

---

## 4️⃣ Suppression des doublons

Commande :

```bash
awk '{print $1}' /var/log/nginx/access.log | sort | uniq
```

📸 image 3

### Résultat obtenu

127.0.0.1

### Explication

* sort trie les données
* uniq supprime les doublons

---

## 5️⃣ Sauvegarde des IP

Commande :

```bash
awk '{print $1}' /var/log/nginx/access.log | sort | uniq > /home/ubuntu/nginx_ips.txt
```

📸 image 4

### Vérification :

```bash
cat /home/ubuntu/nginx_ips.txt
```

📸 image 5

### Résultat

127.0.0.1

---

## 6️⃣ Création du script

Commande :

```bash
nano /home/ubuntu/scruter_nginx.sh
```

📸 image 6

### Contenu du script

```bash
#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"

awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE

echo "Script exécuté le $(date)" >> /home/ubuntu/nginx_ips.log
```

---

### Rendre exécutable

```bash
chmod +x /home/ubuntu/scruter_nginx.sh
```

📸 image 7

---

### Test du script

```bash
/home/ubuntu/scruter_nginx.sh
```

📸 image 8

### Résultat

Le fichier nginx_ips.txt contient les IP extraites.

---

## 7️⃣ Automatisation avec Cron

Commande :

```bash
crontab -e
```

📸 image 9

Configuration :

```bash
0 * * * * /home/ubuntu/scruter_nginx.sh
```

---

### Vérification

```bash
systemctl status cron
```

📸 image 10

### Résultat

Service actif (running)

---

## 8️⃣ Organisation du projet

Structure :

300138573
│
├── README.md
├── scruter_nginx.sh
└── images
└── gitkeep

📸 image 11

---

## 9️⃣ Gestion avec Git

Commandes :

```bash
git add .
git commit -m "CRON TASK"
git pull --rebase origin main
git push origin main
```

📸 image 12

---

## 🧠 Conclusion

Ce laboratoire m’a permis de :

* analyser les logs Nginx
* extraire les IP avec awk
* automatiser un script avec cron
* utiliser Git et GitHub

Ces compétences sont importantes en administration système Linux.



