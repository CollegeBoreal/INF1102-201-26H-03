# TP CRON – Surveillance NGINX
## INF1102 (201) – Programmation de systèmes (Section 3)

**Étudiant :** Medjkoune Belkacem  
**ID Boréal :** 300150385  
**Machine virtuelle :** 10.7.237.215  
**Serveur web :** NGINX  
**Système :** Ubuntu 22.04 LTS  

---

# 🎯 Objectif du TP

Surveiller le système Linux en temps réel et analyser les journaux NGINX.

Le but est :

- Extraire les adresses IP des visiteurs
- Automatiser l’analyse avec un script Bash
- Programmer l’exécution automatique avec CRON

---

# 1️⃣ Surveillance en temps réel

Commandes utilisées :

```bash
top
htop
ps aux
uptime
free -h
df -h
2️⃣ Analyse des logs NGINX

Fichier analysé :

/var/log/nginx/access.log


Extraction des IP :

sudo awk '{print $1}' /var/log/nginx/access.log


IP uniques :

sudo awk '{print $1}' /var/log/nginx/access.log | sort | uniq


Export vers un fichier :

sudo awk '{print $1}' /var/log/nginx/access.log | sort | uniq > /home/ubuntu/nginx_ips.txt

📸 Capture – Fichier nginx_ips.txt

Commentaire :
Cette capture montre les adresses IP uniques extraites du fichier access.log de NGINX.

3️⃣ Création du script automatisé

Fichier créé :

/home/ubuntu/scruter_nginx.sh


Contenu du script :

#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"
LOG_EXEC="/home/ubuntu/nginx_execution.log"

awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE
echo "Script exécuté le $(date)" >> $LOG_EXEC


Rendre exécutable :

chmod +x /home/ubuntu/scruter_nginx.sh


Exécution manuelle :

/home/ubuntu/scruter_nginx.sh

📸 Capture – Exécution du script

Commentaire :
Cette capture montre l’exécution manuelle du script ainsi que l’enregistrement de la date d’exécution dans le fichier nginx_execution.log.

![Wait]("https://github.com/user-attachments/assets/1fc8d902-3b2a-43dc-8ca3-9faf45e981cc")


4️⃣ Automatisation avec CRON

Édition de la crontab :

crontab -e


Ligne ajoutée :

0 * * * * /home/ubuntu/scruter_nginx.sh


Vérification :

crontab -l

📸 Capture – CRONTAB

![Wait](https://github.com/user-attachments/assets/608b1c22-8e45-4515-bb35-23144fd5b71a)


Commentaire :
Cette capture confirme que le script est programmé pour s’exécuter automatiquement toutes les heures.

5️⃣ Vérification du service CRON

Commande utilisée :

systemctl status cron

📸 Capture – Service CRON actif

![cron_status](images/systemctl status cron.png)

Commentaire :
Cette capture montre que le service CRON est actif et en cours d’exécution sur le système.

🔎 Bonus – IP les plus fréquentes

Commande utilisée :

sudo awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -nr > /home/ubuntu/nginx_ips_freq.txt


Cette commande permet d’identifier les visiteurs les plus actifs.

✅ Conclusion

Dans ce TP, nous avons :

✔ Surveillé le système en temps réel
✔ Analysé les logs NGINX
✔ Créé un script Bash d’automatisation
✔ Programmé l’exécution automatique avec CRON
✔ Vérifié le bon fonctionnement du service

Le système est maintenant capable d’analyser automatiquement les visiteurs du serveur web.

