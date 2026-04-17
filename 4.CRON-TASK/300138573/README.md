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

```bash
cat /var/log/nginx/access.log
```

<img width="1168" height="119" alt="Tronc-task5" src="https://github.com/user-attachments/assets/97235481-bf2a-42ba-a63c-fe7ea17bcde8" />

Ce fichier contient toutes les requêtes HTTP du serveur.

---

## 3️⃣ Extraction des adresses IP

Commande utilisée :

```bash
awk '{print $1}' /var/log/nginx/access.log
```
<img width="1482" height="121" alt="Tronc-task6" src="https://github.com/user-attachments/assets/3c371447-7cda-446b-bf3c-838105b3833a" />

### Résultat obtenu

127.0.0.1

127.0.0.1

### Explication

La commande awk permet d’extraire la première colonne du fichier, qui correspond à l’adresse IP.

---

## 4️⃣ Suppression des doublons

Commande :

```bash
awk '{print $1}' /var/log/nginx/access.log | sort | uniq
```
<img width="1482" height="132" alt="Tronc-task8" src="https://github.com/user-attachments/assets/7666c91a-7aa0-4896-a451-fda3ffe7cc22" />

<img width="1482" height="78" alt="Tronc-task7" src="https://github.com/user-attachments/assets/45510547-e6e4-4110-9dbb-f45582a909a1" />


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

### Vérification :

```bash
cat /home/ubuntu/nginx_ips.txt
```

<img width="1482" height="132" alt="Tronc-task8" src="https://github.com/user-attachments/assets/16ab4050-b431-4f14-adb4-53980f345b4e" />


### Résultat

127.0.0.1

---

## 6️⃣ Création du script

Commande :

```bash
nano /home/ubuntu/scruter_nginx.sh
```

### Contenu du script

```bash
#!/bin/bash

# Fichier des logs
LOG_FILE="/var/log/nginx/access.log"

# Fichier de sortie
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"

# Extraire les IP uniques et les stocker
awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE

# Optionnel : ajouter un timestamp à chaque exécution
echo "Script exécuté le $(date)" >> /home/ubuntu/nginx_ips.log
```

---

### Rendre exécutable

```bash
chmod +x /home/ubuntu/scruter_nginx.sh
```

---

### Test du script

```bash
/home/ubuntu/scruter_nginx.sh
```

<img width="1428" height="125" alt="Tronc-task9" src="https://github.com/user-attachments/assets/70cf420d-0034-44e9-a23a-c9a187bab374" />


### Résultat

Le fichier nginx_ips.txt contient les IP extraites.

---

## 7️⃣ Automatisation avec Cron

Commande :

```bash
crontab -e
```

<img width="1454" height="75" alt="Tronc-task10" src="https://github.com/user-attachments/assets/17f16727-3c32-4e89-ac01-de4b9b3aa362" />

Configuration :

```bash
0 * * * * /home/ubuntu/scruter_nginx.sh
```
<img width="1482" height="749" alt="Tronc-task11" src="https://github.com/user-attachments/assets/ff6acfd5-4b2a-4a1e-b9bd-32c6bd1a0c78" />

---

### Vérification

```bash
systemctl status cron
```

<img width="1482" height="545" alt="Tronc-task12" src="https://github.com/user-attachments/assets/c6e18a32-6949-4bbe-99cc-8811d5ad9f24" />

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

---

## 9️⃣ Gestion avec Git

Commandes :

```bash
git add .
git commit -m "CRON TASK"
git pull --rebase origin main
git push origin main
```

<img width="1449" height="637" alt="Tronc-task111" src="https://github.com/user-attachments/assets/8308ef97-2e9b-4235-aa58-92a503cee2ed" />


---

## 🧠 Conclusion

Ce laboratoire m’a permis de :

* analyser les logs Nginx
* extraire les IP avec awk
* automatiser un script avec cron
* utiliser Git et GitHub

Ces compétences sont importantes en administration système Linux.



